Return-Path: <linux-kernel-owner+w=401wt.eu-S1751708AbXANXH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbXANXH3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 18:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbXANXH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 18:07:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:17974 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbXANXH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 18:07:27 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=Yph2us5nzvneruVJHDosjo5uQnm646L0UgWKo9qBM56NgX6BuJqBGXr7UckKHKa2REdcHXUX+ureHIiXxfF4v77xdkdvYvXkLNelS2qCnV9vicWCXL06hajCdb0Mou7J8RIMIY2wrNp2+TIxTu2VwTfUV7/xk5aRsI9SKMaSSY0=
Date: Mon, 15 Jan 2007 01:07:18 +0200
To: Dave Airlie <airlied@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc5] intel_rng: substitue magic PCI IDs with macros
Message-ID: <20070114230718.GB3874@Ahmed>
Mail-Followup-To: Dave Airlie <airlied@gmail.com>,
	Arjan van de Ven <arjan@infradead.org>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
References: <20070114172421.GA3874@Ahmed> <1168796241.3123.954.camel@laptopd505.fenrus.org> <21d7e9970701141131n24bb371di2c941c681b4afdf8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970701141131n24bb371di2c941c681b4afdf8@mail.gmail.com>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 06:31:01AM +1100, Dave Airlie wrote:
> On 1/15/07, Arjan van de Ven <arjan@infradead.org> wrote:
> >On Sun, 2007-01-14 at 19:24 +0200, Ahmed S. Darwish wrote:
> >> Substitue intel_rng magic PCI IDs values used in the IDs table
> >> with the macros defined in pci_ids.h
> >>
> >Hi,
> >
> >hmm this is actually the opposite direction than most of the kernel is
> >heading in, mostly because the pci_ids.h file is a major maintenance
> >pain.
> >
> >Afaik the current "rule" is: if a PCI ID is only used in one driver, use
> >the numeric value and not (add) a symbolic constant.
> >
> 
> My guess is that the RNG is on the LPC so the values are used in a few 
> places..
> 

Will pci_ids.h be removed from the tree some time in the future then ?

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
