Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937972AbWLGPTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937972AbWLGPTn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937975AbWLGPTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:19:43 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3172 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937972AbWLGPTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:19:43 -0500
Date: Thu, 7 Dec 2006 16:19:41 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] PCI MMConfig: Share what's shareable.
Message-ID: <20061207151941.GA45592@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Muli Ben-Yehuda <muli@il.ibm.com>, Andi Kleen <ak@suse.de>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061207144952.GA45089@dspnet.fr.eu.org> <20061207150023.GH28515@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207150023.GH28515@rhun.haifa.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 05:00:23PM +0200, Muli Ben-Yehuda wrote:
> On Thu, Dec 07, 2006 at 03:49:53PM +0100, Olivier Galibert wrote:
> 
> > +void __init pci_mmcfg_init(int type)
> > +{
> > +	extern int pci_mmcfg_arch_init(void);
> 
> Please put this in a suitable header file.

Sure, which ?

  OG.
