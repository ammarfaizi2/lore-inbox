Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSFTPg4>; Thu, 20 Jun 2002 11:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSFTPgz>; Thu, 20 Jun 2002 11:36:55 -0400
Received: from ns.suse.de ([213.95.15.193]:26640 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315167AbSFTPgx>;
	Thu, 20 Jun 2002 11:36:53 -0400
Date: Thu, 20 Jun 2002 17:36:54 +0200
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020620173654.O29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <200206200711.RAA10165@thucydides.inspired.net.au> <Pine.LNX.4.44.0206200800260.8012-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0206200800260.8012-100000@home.transmeta.com>; from torvalds@transmeta.com on Thu, Jun 20, 2002 at 08:13:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 08:13:22AM -0700, Linus Torvalds wrote:
 > and then look at the whole glory in some graphical file manager to get a
 > view of the tree (actually, most file managers are somewhat confused about
 > the fact that the directory counts don't reflect sub-directories, so you
 > may have to open the subdirectories by hand, whatever. That's a bug.
 > Should be fixed. I'm cc'ing Pat)

Is this the same bug that causes this wierdo..

(davej@mesh:drivers)$ pwd
/driver/bus/pci/drivers
(davej@mesh:drivers)$ ls -l
ls: VIA 82C686A/B: No such file or directory
total 0
drwxr-xr-x    1 root     root            0 Jun 19 22:34 3c59x/
drwxr-xr-x    1 root     root            0 Jun 19 22:34 Sound Fusion CS46xx/
drwxr-xr-x    1 root     root            0 Jun 19 22:34 bttv/
drwxr-xr-x    1 root     root            0 Jun 19 22:34 parport_pc/
drwxr-xr-x    1 root     root            0 Jun 19 22:34 serial/

(Note the VIA line)

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
