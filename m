Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129694AbRBNAkd>; Tue, 13 Feb 2001 19:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRBNAkX>; Tue, 13 Feb 2001 19:40:23 -0500
Received: from mail-3.addcom.de ([62.96.128.37]:5902 "HELO mail-3.addcom.de")
	by vger.kernel.org with SMTP id <S129694AbRBNAkM>;
	Tue, 13 Feb 2001 19:40:12 -0500
Date: Wed, 14 Feb 2001 01:41:59 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: <thunder7@xs4all.nl>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <keil@isdn4linux.de>
Subject: Re: 2.2.19pre10 locks up hard on unloading the isdn module 'hisax.o'
In-Reply-To: <20010213215158.A967@middle.of.nowhere>
Message-ID: <Pine.LNX.4.30.0102140052170.3833-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001 thunder7@xs4all.nl wrote:

> SMP machine, 2x P3/700 on an Abit VP6.
> Never any trouble with the earlier 2.2.19pre's.
> 
> a strace shows the hang to be in the delete_module("hisax") call.

I got another report of the same problem already. I'll try to sort it out 
tomorrow.

What does "ps axwll" say for the rmmod process?

--Kai






