Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTFIPMT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 11:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTFIPMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 11:12:19 -0400
Received: from a4.veijo.ton.tut.fi ([193.166.236.20]:9451 "EHLO
	butthead.ton.tut.fi") by vger.kernel.org with ESMTP id S264450AbTFIPMS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 11:12:18 -0400
From: Sami Nieminen <sami.nieminen@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.5.69-mm6
Date: Mon, 9 Jun 2003 18:25:57 +0300
User-Agent: KMail/1.5.9
References: <200306091819.48459.sami.nieminen@iki.fi>
In-Reply-To: <200306091819.48459.sami.nieminen@iki.fi>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306091825.57588.sami.nieminen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Has anyone figured out the radeon_cp_init problem? I am still suffering of 
this with 2.5.70-bk14. This is with Gentoo 1.4 and gcc 3.2.3 (on a notebook 
with Radeon 9000 Mobility and SiS AGP chipset).

Regards, Sami

P.S. Please CC me any reply as I am not subscribed to the list.

> On Mon, 19 May 2003, Alexander Hoogerhuis wrote:
> > --[PinePGP]--------------------------------------------------[begin]--
> > The oops is gone, and I'm now left with this one:
>
> Ultra Cool
>
> > Linux agpgart interface v0.100 (c) Dave Jones
> > [drm] Initialized radeon 1.8.0 20020828 on minor 0
> > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> > [drm:radeon_unlock] *ERROR* Process 4421 using kernel context 0
> >
> > This one only seems to appear when I'm compiling it modular.
>
> Wading through that code isn't something to undertake at this hour, i'll
> have a look a bit later.
>
>         Zwane

-- 
Linux 2.5.70-bk14
