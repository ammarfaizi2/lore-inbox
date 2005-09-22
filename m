Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbVIVCna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbVIVCna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 22:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVIVCna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 22:43:30 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:39724 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965215AbVIVCn3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 22:43:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CiSlq0lu6g8x6933cV4NmrlWUoZy4ctK+zsyoVG8MIQBMoEfqnkTIoH3pIZbKWY1F/JEa4P/M7aTQL3E90PPZiQMCwSW43NxieJOz7Qd9wrt8++HURXLv7va4qnSHn/aWWilqZ3vtXltIJ2NQrDPVFCBXu+JZZCcmQ135BvReOQ=
Message-ID: <1e62d1370509211943443ba3ea@mail.gmail.com>
Date: Thu, 22 Sep 2005 07:43:26 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: Fawad Lateef <fawadlateef@gmail.com>
To: Nick Warne <nick@linicks.net>
Subject: Re: A pettiness question.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509212046.15793.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509212046.15793.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/05, Nick Warne <nick@linicks.net> wrote:
>
> Interesting.  I thought maybe this way was trick, until later I experimented.
>
> My post here (as Bill Stokes):
>
> http://www.quakesrc.org/forums/viewtopic.php?t=5626
>
> So what is the reason to doing !!num as opposed to num ? 1:0 (which is more
> readable I think, especially to a lesser experienced C coder).  Quicker to
> type?
>

I think using !! is quick and the place where it is used, will look
little bit odd (like you say in #define or macros) if some one use num
? 1 : 0 ...... And I think lesser experienced C coder will learn other
ways of doing same things !!!!!

> My quick test shows compiler renders both the same?
>

Ya, I think both !! and num ? 1: 0 will result in same thing by compiler

--
Fawad Lateef
