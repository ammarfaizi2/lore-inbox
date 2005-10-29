Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbVJ2W0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbVJ2W0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbVJ2W0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:26:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932644AbVJ2W0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:26:00 -0400
Date: Sat, 29 Oct 2005 15:25:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Deepak Saxena <dsaxena@plexity.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tony@atomide.com,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 0/5] HW RNG cleanup & new drivers
In-Reply-To: <4363F31F.2040303@pobox.com>
Message-ID: <Pine.LNX.4.64.0510291524050.3348@g5.osdl.org>
References: <20051029191229.562454000@omelas> <4363F31F.2040303@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Oct 2005, Jeff Garzik wrote:
>
> I would prefer to let this live in -mm at least for a little while.
> Confirmation from AMD, Intel and VIA owners would be really nice, too. AMD and
> Intel might be a little bit hard to find.  I think Peter Anvin had an Intel
> ICH w/ RNG at one time...

I'm just wondering why via/amd/intel end up being one driver. It would 
seem to be more sensible to have separate drivers for them, since they 
have no real overlap..

		Linus
