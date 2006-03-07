Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWCGSpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWCGSpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWCGSpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:45:09 -0500
Received: from xenotime.net ([66.160.160.81]:53451 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751112AbWCGSpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:45:07 -0500
Date: Tue, 7 Mar 2006 10:46:46 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Reg Clemens <reg@dwf.com>
Cc: reg@dwf.com, rlrevell@joe-job.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, reg@deneb.dwf.com
Subject: Re: vmlinuz-2.6.16-rc5-git8 still nogo with Intel D945 Motherboard
Message-Id: <20060307104646.9b2e193d.rdunlap@xenotime.net>
In-Reply-To: <200603071820.k27IKSsm003595@deneb.dwf.com>
References: <200603070340.k273ev0A003594@deneb.dwf.com>
	<1141703317.25487.142.camel@mindpipe>
	<200603070823.k278NE9o006674@deneb.dwf.com>
	<20060307081806.0af1d2c4.rdunlap@xenotime.net>
	<200603071820.k27IKSsm003595@deneb.dwf.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2006 11:20:28 -0700 Reg Clemens wrote:

> 
> > I meant, narrow it down by identifying the change that broke it.
> > "Somewhere between 2.6.11 and 2.6.15" is not helpful.
> 
> Yes, I can do that, but not till this evening.
> 
> > The HD (high-definition) audio driver works for me.
> > Are you using a vendor/distro kernel or roll-your-own?
> 
> Im building my own kernels.
> 
> > Maybe try the latest e1000 driver from
> >  http://sourceforge.net/projects/e1000/
> 
> Ill give that a shot, but again probably not till this evening.
> 
> > Can you post the complete boot log instead of one line of it?
> 
> Sure.
> In fact, Ill give you two, first the bad boot from 2.6.16, then a
> good boot from 1.6.11 just in case you need something to compare
> against.
> 
> Here they are, In the bad boot, the lines of interest are between
> lines 115 and 120, and start with PCI: Cannot and PCI: Failed .

Both boot logs contains the Cannot messages.
The "bad" log also contains:
Mar  7 10:58:41 deneb kernel: PCI: Failed to allocate mem resource #6:20000@48000000 for 0000:01:00.0

Is device 0:01:00.0 your Nvidia video card?
Is there an updated NVRM driver for it (guessing from your OK boot log)
for 2.6.15 or later?

I suppose an lspci might help.  I dunno.

---
~Randy
