Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbREVSsu>; Tue, 22 May 2001 14:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262718AbREVSsk>; Tue, 22 May 2001 14:48:40 -0400
Received: from www.teaparty.net ([216.235.253.180]:61194 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S262719AbREVSse>;
	Tue, 22 May 2001 14:48:34 -0400
Date: Tue, 22 May 2001 19:47:44 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Prasad <prasad_s@gdit.iiit.net>, linux-kernel@vger.kernel.org
Subject: Re: Changes in Kernel
In-Reply-To: <E152GlV-0002Hh-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10105221932170.8937-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001, Alan Cox wrote:

> Are there specific reasons you cannot just use the existing ioctls to load
> fonts ? The console driver already supports Klingon for example.
> 
> What are the issues - writing right - left ?

No, but in some scripts [devanagari anyway] you only ever write a vowel as
a letter if it's at the front of the word: otherwise vowels are added as 
sort of 'accents' to the consonants, plus there are letters that sometimes
smoosh together if they are next to one another, iirc, and long and short
forms for each vowel, and each accent-form, plus there are other
idiosyncrasies...

There seems to be kanji console thing called kon, looking at the package,
it looks like it's implemented in userspace - perhaps a similar approach
would be fruitful?

-- 
Just one nuclear family can ruin your whole life.

