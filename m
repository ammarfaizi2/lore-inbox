Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWBMOw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWBMOw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWBMOw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:52:26 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:25935 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751280AbWBMOwZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:52:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VAC2+AAeo2XWQASA66mOeOnIIEe2KuQr3BMNPMdUm6+5baih8e8F3hxwlm60sCkSzxZ294f3Unq75WuJ6WjHyZJTX0DRh682dirvh78VAUku5iVBI2oUo9p7NjpbJu8vFSaclxwvULBXaVVWTlVcbqE7t0DrVEv6O1ykWaKh0iQ=
Message-ID: <728201270602130652w5c95788eud0cabfdc8dd17f48@mail.gmail.com>
Date: Mon, 13 Feb 2006 08:52:24 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: Chris Siebenmann <cks@utcc.utoronto.ca>
Subject: Re: RSS Limit implementation issue
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <06Feb11.024837est.33911@gpu.utcc.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <mail.linux.kernel/728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com>
	 <06Feb11.024837est.33911@gpu.utcc.utoronto.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/06, Chris Siebenmann <cks@utcc.utoronto.ca> wrote:

>  I suggest a third method: steal another page from the process itself.
> This automatically keeps the process within its own RSS, slows down its
> activities, *and* lets it keep running.
>
>  Under the name 'paging against itself', I believe this has probably
> already been done by various people in the early 1990s.

This method may cause increased amount of swapping affecting the
overall system performance.

Thanks
Ram Gupta
