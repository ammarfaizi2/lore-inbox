Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269256AbUINKx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269256AbUINKx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 06:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269257AbUINKx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 06:53:27 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:46773 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269256AbUINKxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:53:21 -0400
Message-ID: <9ae345c0040914035331f17465@mail.gmail.com>
Date: Tue, 14 Sep 2004 13:53:19 +0300
From: Yuval Turgeman <yuvalt@gmail.com>
Reply-To: Yuval Turgeman <yuvalt@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Menuconfig search changes - pt. 3
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0409140111100.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040903190023.GA8898@aduva.com>
	 <Pine.LNX.4.61.0409040152160.877@scrub.home>
	 <9ae345c0040904101365a1ca63@mail.gmail.com>
	 <Pine.LNX.4.61.0409140111100.877@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 01:16:01 +0200 (CEST), Roman Zippel
<zippel@linux-m68k.org> wrote:

> Could you please resend one complete (logical) patch.

I did - http://lkml.org/lkml/2004/9/4/155 (patch against mm3)

> Something I'd really like to see before merging this (besides other small
> fixes) is separating the search into a function, which returns the result
> in a NULL terminated, allocated array.

I agree - exporting the search function to a seperate location in
order to use it in other guis (the patch above only applies to mconf).

Thanks,
Yuval.

--
Yuval Turgeman
