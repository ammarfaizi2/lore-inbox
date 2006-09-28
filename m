Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751924AbWI1Qci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbWI1Qci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWI1Qch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:32:37 -0400
Received: from gw.goop.org ([64.81.55.164]:16357 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751660AbWI1Qcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:32:36 -0400
Message-ID: <451BF92F.1010403@goop.org>
Date: Thu, 28 Sep 2006 09:32:47 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
References: <451B64E3.9020900@goop.org>	<20060927233509.f675c02d.akpm@osdl.org>	<451B708D.20505@goop.org>	<20060928000019.3fb4b317.akpm@osdl.org>	<451BA380.7030502@goop.org> <20060928091809.0253ce4f.akpm@osdl.org>
In-Reply-To: <20060928091809.0253ce4f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> - We're using ten bytes of instruction cache where we could use two bytes
>   

My patch reduces it to 5, but 2 would be better.

> - If this is done right, other architectures can use the look-it-up code,
>   thus cleaning up the kernel codebase.
>
> And looky, powerpc already does this, so it'd be a matter of librarifying
> their code.
>   

I'll have a look.

    J
