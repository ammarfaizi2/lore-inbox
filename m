Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265550AbTFRVqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265552AbTFRVqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:46:05 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44171 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265550AbTFRVqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:46:03 -0400
Date: Wed, 18 Jun 2003 14:57:06 -0700
From: Greg KH <greg@kroah.com>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, willy@fc.hp.com, linux-kernel@vger.kernel.org
Subject: Re: move pci_domain_nr() inside "#ifdef CONFIG_PCI" bracket
Message-ID: <20030618215706.GA1919@kroah.com>
References: <16112.54572.443092.996206@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16112.54572.443092.996206@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 02:10:04PM -0700, David Mosberger wrote:
> Trivial build fix: pci_domain_nr() cannot be declared unless
> CONFIG_PCI is defined (otherwise, struct pci_bus hasn't been defined).

Thanks, I've added this to my pci bk tree and will send it off to Linus
in a bit.

greg k-h
