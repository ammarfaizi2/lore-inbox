Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129442AbRBBOqu>; Fri, 2 Feb 2001 09:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbRBBOql>; Fri, 2 Feb 2001 09:46:41 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:40004 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S129442AbRBBOqc>; Fri, 2 Feb 2001 09:46:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14970.51264.950601.176653@somanetworks.com>
Date: Fri, 2 Feb 2001 09:46:24 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: Frédéric L. W. Meunier <0@pervalidus.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: problem with devfsd compilation
In-Reply-To: <20010202005036.J160@pervalidus.dyndns.org>
In-Reply-To: <20010202005036.J160@pervalidus.dyndns.org>
X-Mailer: VM 6.75 under 21.2  (beta40) "Persephone" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "M" == Meunier  <iso-8859-1> writes:

 M> Not true. I'm pretty sure /dev/.devfsd is only created when you
 M> mount devfs at boot time or via mount -t devfs devfs /dev in your
 M> system initialization script. Creating /dev/.devfsd with touch
 M> defeats the purpose of /etc/rc.sysinit example.

Right you are.  I looked at all this stuff _before_ I had devfs
mounted.  It never occured to me that "-e /dev/.devfsd" had a
connotation.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
