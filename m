Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWBMUiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWBMUiB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWBMUiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:38:00 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:62046 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964881AbWBMUh7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:37:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iOcQm1PDKyw3lOG5gh70Y92p0AO5ULjpB5OfC76roOFjjP8GysnaVHbU289LJ/y1jaWDkYhjtNDlMgSNY5kq+KhB2w/SN/KiVlEYp0ubXkB85oqG76ZX1F4/bDoGLLupqvFG4nQqGWf4BGSJgGqR4FRA0xOQuBnJVamR0hCbTOQ=
Message-ID: <728201270602131237y5e5ba77axb63a0e6b19ca4337@mail.gmail.com>
Date: Mon, 13 Feb 2006 14:37:57 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: Chris Siebenmann <cks@utcc.utoronto.ca>
Subject: Re: RSS Limit implementation issue
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <06Feb13.151216est.821021@ugw.utcc.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <728201270602130652w5c95788eud0cabfdc8dd17f48@mail.gmail.com>
	 <06Feb13.151216est.821021@ugw.utcc.utoronto.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Chris Siebenmann <cks@utcc.utoronto.ca> wrote:

>
>  I believe that this is the inevitable result of anything that doesn't
> kill the process on the spot. When you put the process to sleep, you
> effectively reduce its RSS by reducing its page-touching activity; if
> the system is under memory pressure, other things will then steal pages
> from it anyways.
>
True  but with your approach swapping occurs right away. Objective
here is to reduce the chances of swapping as much as possible.

Regards
Ram Gupta
