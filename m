Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWJVMYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWJVMYG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 08:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWJVMYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 08:24:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28420 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751784AbWJVMYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 08:24:02 -0400
Date: Sun, 22 Oct 2006 14:23:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Meelis Roos <mroos@linux.ee>, paulus@samba.org, linuxppc-dev@ozlabs.org,
       Martin Lorenz <martin@lorenz.eu.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org,
       Jesper Juhl <jesper.juhl@gmail.com>,
       David Howells <dhowells@redhat.com>,
       James.Bottomley@HansenPartnership.com, pazke@donpac.ru,
       linux-visws-devel@lists.sourceforge.net,
       Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org, art@usfltd.com, ak@suse.de,
       discuss@x86-64.org, Alex Romosan <romosan@sycorax.lbl.gov>,
       Jens Axboe <jens.axboe@oracle.com>, Christian <christiand59@web.de>,
       Mark Langsdorf <mark.langsdorf@amd.com>, davej@codemonkey.org.uk,
       cpufreq@lists.linux.org.uk, Stephen Hemminger <shemminger@osdl.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Prakash Punnoor <prakash@punnoor.de>, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: 2.6.19-rc2: known unfixed regressions (v3)
Message-ID: <20061022122355.GC3502@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known unfixed regressions in 2.6.19-rc2 compared 
to 2.6.18 that are not yet fixed Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : ppc prep boot hang
References : http://lkml.org/lkml/2006/10/14/58
Submitter  : Meelis Roos <mroos@linux.ee>
Status     : unknown


Subject    : X60s: BUG()s, lose ACPI events after suspend/resume
References : http://lkml.org/lkml/2006/10/10/39
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
Status     : unknown


Subject    : T60 stops triggering any ACPI events
References : http://lkml.org/lkml/2006/10/4/425
             http://lkml.org/lkml/2006/10/16/262
Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
Status     : unknown


Subject    : CONFIG_X86_VOYAGER=y, CONFIG_SMP=n compile error
References : http://lkml.org/lkml/2006/10/7/51
Submitter  : Jesper Juhl <jesper.juhl@gmail.com>
Caused-By  : David Howells <dhowells@redhat.com>
             commit 7d12e780e003f93433d49ce78cfedf4b4c52adc5
Status     : unknown


Subject    : CONFIG_X86_VISWS=y, CONFIG_SMP=n compile error
References : http://lkml.org/lkml/2006/10/7/51
Submitter  : Jesper Juhl <jesper.juhl@gmail.com>
Caused-By  : David Howells <dhowells@redhat.com>
             commit 7d12e780e003f93433d49ce78cfedf4b4c52adc5
Status     : unknown


Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
References : http://bugzilla.kernel.org/show_bug.cgi?id=7255
Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
Status     : unknown


Subject    : SMP x86_64 boot problem
References : http://lkml.org/lkml/2006/9/28/330
             http://lkml.org/lkml/2006/10/5/289
Submitter  : art@usfltd.com
Status     : submitter was asked to git bisect
             result of bisecting seems to be wrong


Subject    : unable to rip cd
References : http://lkml.org/lkml/2006/10/13/100
Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
Status     : unknown


Subject    : cpufreq not working on AMD K8
References : http://lkml.org/lkml/2006/10/10/114
Submitter  : Christian <christiand59@web.de>
Handled-By : Mark Langsdorf <mark.langsdorf@amd.com>
Status     : Mark is investigating


Subject    : MSI errors during boot (CONFIG_PCI_MULTITHREAD_PROBE)
References : http://lkml.org/lkml/2006/10/16/291
Submitter  : Stephen Hemminger <shemminger@osdl.org>
Handled-By : Greg KH <greg@kroah.com>
Status     : Greg is working on a fix


Subject    : snd-hda-intel <-> forcedeth MSI problem
References : http://lkml.org/lkml/2006/10/5/40
             http://lkml.org/lkml/2006/10/7/164
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : patches are being discussed


