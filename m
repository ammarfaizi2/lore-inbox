Return-Path: <linux-kernel-owner+w=401wt.eu-S1753555AbWLOXf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbWLOXf5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 18:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbWLOXf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 18:35:56 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:39936 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554AbWLOXfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 18:35:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
Date: Sat, 16 Dec 2006 00:38:02 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@suse.de>,
       Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, Tejun Heo <htejun@gmail.com>,
       Alan <alan@lxorguk.ukuu.org.uk>
References: <20061204203410.6152efec.akpm@osdl.org> <200612152322.26375.rjw@sisk.pl> <45832095.9000503@garzik.org>
In-Reply-To: <45832095.9000503@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612160038.03149.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 15 December 2006 23:24, Jeff Garzik wrote:
> Rafael J. Wysocki wrote:
> > On Friday, 15 December 2006 22:39, Andrew Morton wrote:
> >> On Fri, 15 Dec 2006 13:05:52 -0800
> >> Andrew Morton <akpm@osdl.org> wrote:
> >>
> >>> Jeff, I shall send all the sata patches which I have at you one single time
> >>> and I shall then drop the lot.  So please don't flub them.
> >>>
> >>> I'll then do a rc1-mm2 without them.
> >> hm, this is looking like a lot of work for not much gain.  Rafael, are
> >> you able to do a quick chop and tell us whether these:
> >>
> >> pci-move-pci_vdevice-from-libata-to-core.patch
> >> pata_cs5530-suspend-resume-support-tweak.patch
> >> ata-fix-platform_device_register_simple-error-check.patch
> >> initializer-entry-defined-twice-in-pata_rz1000.patch
> >> pata_via-suspend-resume-support-fix.patch
> >> sata_nv-add-suspend-resume-support.patch
> >> libata-simulate-report-luns-for-atapi-devices.patch
> >> user-of-the-jiffies-rounding-patch-ata-subsystem.patch
> >> libata-fix-oops-with-sparsemem.patch
> >> sata_nv-fix-kfree-ordering-in-remove.patch
> >> libata-dont-initialize-sg-in-ata_exec_internal-if-dma_none-take-2.patch
> >> pci-quirks-fix-the-festering-mess-that-claims-to-handle-ide-quirks-ide-fix.patch
> >>
> >> are innocent?
> > 
> > Yes, they are.
> 
> We all really appreciate your patience :)  This is good feedback.
> 
> To narrow down some more, does applying 2.6.20-rc1 + the attached patch 
> work?  (ignoring -mm tree altogether)

Yes, it does.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
