Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVFTRBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVFTRBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVFTRBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 13:01:13 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:19631 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261200AbVFTRBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 13:01:08 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: davidm@hpl.hp.com
Subject: Re: [resend][PATCH] avoid signed vs unsigned comparison in efi_range_is_wc()
Date: Mon, 20 Jun 2005 10:00:04 -0700
User-Agent: KMail/1.8
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>,
       Walt Drummond <drummond@valinux.com>,
       Stephane Eranian <eranian@hpl.hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost> <17073.59550.679017.387092@napali.hpl.hp.com>
In-Reply-To: <17073.59550.679017.387092@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506201000.04665.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 16, 2005 2:01 pm, David Mosberger wrote:
> >>>>> On Thu, 16 Jun 2005 22:21:50 +0200 (CEST), Jesper Juhl
> >>>>> <juhl-lkml@dif.dk> said:
>
>   Jesper> I send in the patch below a while back but never recieved
>   Jesper> any response.  Now I'm resending it in the hope that it
>   Jesper> might be added to -mm.  The patch still applies cleanly to
>   Jesper> 2.6.12-rc6-mm1
>
> The patch looks fine to me.

Yep, looks good.  I was the one that introduced this bug.  It's hard to 
hit, but we should still fix it.  Thanks Jesper.

Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

Jesse
