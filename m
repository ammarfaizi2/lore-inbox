Return-Path: <linux-kernel-owner+w=401wt.eu-S964929AbXABTaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbXABTaB (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbXABTaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:30:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2426 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964928AbXABT37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:29:59 -0500
Date: Tue, 2 Jan 2007 20:30:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, Paul Moore <paul.moore@hp.com>,
       Parag Warudkar <paragw@paragw.zapto.org>, sds@tycho.nsa.gov,
       jmorris@namei.org, netdev@vger.kernel.org,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       Ben Castricum <mail0612@bencastricum.nl>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: 2.6.20-rc3: known regressions with patches available (part 2)
Message-ID: <20070102193001.GW20714@stusta.de>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc3 compared to 2.6.19
with patches available

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : selinux networking: sleeping function called from invalid context
References : http://lkml.org/lkml/2006/12/24/78
Submitter  : Adam J. Richter <adam@yggdrasil.com>
Caused-By  : Paul Moore <paul.moore@hp.com>
Handled-By : Parag Warudkar <paragw@paragw.zapto.org>
Patch      : http://lkml.org/lkml/2006/12/24/89
Status     : patch available


Subject    : kernel panics on boot (libata-sff)
References : http://lkml.org/lkml/2006/12/3/99
             http://lkml.org/lkml/2006/12/14/153
             http://lkml.org/lkml/2006/12/24/33
             http://lkml.org/lkml/2007/1/1/84
Submitter  : Alessandro Suardi <alessandro.suardi@gmail.com>
             Theodore Tso <tytso@mit.edu>
Caused-By  : Alan Cox <alan@lxorguk.ukuu.org.uk>
             commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f
Handled-By : Alan Cox <alan@lxorguk.ukuu.org.uk>
             Jeff Garzik <jeff@garzik.org>
Patch      : http://lkml.org/lkml/2007/1/2/64
Status     : patch available


Subject    : PCI_MULTITHREAD_PROBE breakage
References : http://lkml.org/lkml/2006/12/12/21
Submitter  : Ben Castricum <mail0612@bencastricum.nl>
Caused-By  : Greg Kroah-Hartman <gregkh@suse.de>
             commit 009af1ff78bfc30b9a27807dd0207fc32848218a
Handled-By : Greg Kroah-Hartman <gregkh@suse.de>
Status     : patch available
