Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032307AbWLGPfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032307AbWLGPfM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032306AbWLGPfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:35:12 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:16024 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937983AbWLGPfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:35:09 -0500
Date: Thu, 7 Dec 2006 17:35:06 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] PCI MMConfig: Share what's shareable.
Message-ID: <20061207153506.GJ28515@rhun.haifa.ibm.com>
References: <20061207144952.GA45089@dspnet.fr.eu.org> <20061207150023.GH28515@rhun.haifa.ibm.com> <20061207151941.GA45592@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207151941.GA45592@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 04:19:41PM +0100, Olivier Galibert wrote:
> On Thu, Dec 07, 2006 at 05:00:23PM +0200, Muli Ben-Yehuda wrote:
> > On Thu, Dec 07, 2006 at 03:49:53PM +0100, Olivier Galibert wrote:
> > 
> > > +void __init pci_mmcfg_init(int type)
> > > +{
> > > +	extern int pci_mmcfg_arch_init(void);
> > 
> > Please put this in a suitable header file.
> 
> Sure, which ?

arch/i386/pci/pci.h seems the least-inappropriate.

Also, forgot to mention, please get rid of C++ style comments in the
code.

Cheers,
Muli
