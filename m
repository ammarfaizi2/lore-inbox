Return-Path: <linux-kernel-owner+w=401wt.eu-S1758292AbWLIVo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758292AbWLIVo5 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758281AbWLIVo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:44:57 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3875 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758272AbWLIVo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:44:57 -0500
Date: Sat, 9 Dec 2006 22:44:53 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jean Delvare <khali@linux-fr.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sysfs file creation result nightmare (WAS radeonfb: Fix sysfs_create_bin_file warnings)
Message-ID: <20061209214453.GA69320@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andrew Morton <akpm@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jean Delvare <khali@linux-fr.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20061209165606.2f026a6c.khali@linux-fr.org> <1165694351.1103.133.camel@localhost.localdomain> <20061209123817.f0117ad6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061209123817.f0117ad6.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2006 at 12:38:17PM -0800, Andrew Morton wrote:
> On Sun, 10 Dec 2006 06:59:10 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > Why would I prevent the framebuffer from initializing (and thus a
> > console to be displayed at all on many machines) just because for some
> > reason, I couldn't create a pair of EDID files in sysfs that are not
> > even very useful anymore ?
> 
> Because there's a bug in your kernel.  We don't hide and work around bugs.

Hmmm, I don't understand.  Which is the bug, having a sysfs file
creation fail or going on if it happens?

  OG.

