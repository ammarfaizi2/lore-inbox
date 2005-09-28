Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbVI1R3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbVI1R3k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbVI1R3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:29:40 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:8036 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751458AbVI1R3j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:29:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TLN9CvdcNvuF5YtCODx4vAn5xAC85ym9o8vbV/pRQPc0DKIwjxEqE0T7DDMsHM9riotsrR7ar0HIPmqcz6iv8MPNsKIqnEQRuY8CiPJfcvy+m4cTMuX7S0DfvGB8f3n9/3AyPuxD2Fne/jLrgtCPI+snGcLH/h5alJXnBuJF5Tk=
Message-ID: <69304d110509281029a1b028a@mail.gmail.com>
Date: Wed, 28 Sep 2005 19:29:38 +0200
From: Antonio Vargas <windenntw@gmail.com>
Reply-To: Antonio Vargas <windenntw@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: fat / multi arch binaries?
In-Reply-To: <200509281918.56386.aj@dungeon.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509281918.56386.aj@dungeon.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, Andreas Jellinghaus <aj@dungeon.inka.de> wrote:
> Hi,
>
> does linux support binaries with code
> for several architectures? I read that
> elf allowes that, and for example
> apple plans to use it on mac os X,
> but I couldn't find anything whether
> such binaries would work with linux
> or not. can you tell me?

OSX begat from NeXT and NeXT had these same "fat binaries". They are not new :)


> if linux supports that, it should
> also work for merging x86 and x86_64
> into one binary? would ther be a way

you don't want that ;)

> to run the 32bit version in the 64bit
> kernel, if requested? are there any

32bit user-space can run 100% on 64bit kernel, this is usual in sparc
if i'm not mistaken

> tools to create such binaries?
>
> with google I found info from 97
> that indicades elf format has no
> provision for fat binaries and linux
> doesn't support them. is that still
> true?

just remember that linux is mainly about source access, so having
"fat" binaries is just wrong because the one-true-way is to get the
sources and compile for your arch directly. this can be done by hand,
semi-automated (aka gentoo) or automated (aka debian, fedora, etc...)
by just installing from precompiled binaries

> Thanks, Andreas
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/


Every day, every year
you have to work
you have to study
you have to scene.
