Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965247AbVI1B4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbVI1B4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 21:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbVI1B4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 21:56:37 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:37490 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965247AbVI1B4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 21:56:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=3xkfHStepJRmmtuu7gUK2EaK2teUXiV2u5vHY566cFAz1w40CERgQRgvTILpksj1c+9Y0Kf8fpcoDqk565WaAqUZ/1hD/pekt25mQExWo8gPPgIFXWOTgsyom3xgdkFo97poh/ap9YCD+5Xwx++kWY/rOf0mhecXzyeRb3+7v58=  ;
Subject: Re: [RFC][PATCH] inline a few tiny functions in init/initramfs.c
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9a87484905092717074e85657e@mail.gmail.com>
References: <200509240126.26575.jesper.juhl@gmail.com>
	 <200509241415.43773.kernel@kolivas.org> <4334DB96.3040904@yahoo.com.au>
	 <9a87484905092717074e85657e@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 11:56:05 +1000
Message-Id: <1127872565.5210.4.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 02:07 +0200, Jesper Juhl wrote:

> Ok, so it seems that there's agreement that the other two inlines in
> the patch makes sense, but the malloc() is not clear cut.
> 
> Since this is in initramfs after all it doesn't make that big a
> difference overall, so I'll just send in a patch that inlines the
> other two functions but leaves malloc() alone.
> 

Well, they're not particularly performance critical, and everything
is marked init anyway so I don't know why you would bother changing
anything ;)

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
