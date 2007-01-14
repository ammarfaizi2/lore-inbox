Return-Path: <linux-kernel-owner+w=401wt.eu-S1751632AbXANTbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbXANTbG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 14:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbXANTbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 14:31:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:50614 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbXANTbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 14:31:05 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GZJRdz8I5RqPOtJ58eHVQB/YisMhXMjIwkMeBaFdRljOTK7h6lSMTjF4NEoubyk13Bub32PZVLUGry5YvODWMsBDobpoGogeRbvtz4yWZcsITVVFVhm5gWHFIq7Bhb8Q/8oaemFbOPC4LnjXYEo8zjs27KybOCkq6wNbJfc0ZXU=
Message-ID: <21d7e9970701141131n24bb371di2c941c681b4afdf8@mail.gmail.com>
Date: Mon, 15 Jan 2007 06:31:01 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [PATCH 2.6.20-rc5] intel_rng: substitue magic PCI IDs with macros
Cc: "Ahmed S. Darwish" <darwish.07@gmail.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1168796241.3123.954.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070114172421.GA3874@Ahmed>
	 <1168796241.3123.954.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/07, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sun, 2007-01-14 at 19:24 +0200, Ahmed S. Darwish wrote:
> > Substitue intel_rng magic PCI IDs values used in the IDs table
> > with the macros defined in pci_ids.h
> >
> Hi,
>
>
> hmm this is actually the opposite direction than most of the kernel is
> heading in, mostly because the pci_ids.h file is a major maintenance
> pain.
>
> Afaik the current "rule" is: if a PCI ID is only used in one driver, use
> the numeric value and not (add) a symbolic constant.
>

My guess is that the RNG is on the LPC so the values are used in a few places..

Dave.
