Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288253AbSACQuJ>; Thu, 3 Jan 2002 11:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288254AbSACQuB>; Thu, 3 Jan 2002 11:50:01 -0500
Received: from sun.fadata.bg ([80.72.64.67]:17412 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S288251AbSACQtP>;
	Thu, 3 Jan 2002 11:49:15 -0500
To: Edgar Toernig <froese@gmx.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <E16Lvh8-0006E6-00@the-village.bc.nu>
	<25193.1010018130@redhat.com> <3C347CC3.E7154C36@gmx.de>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <3C347CC3.E7154C36@gmx.de>
Date: 03 Jan 2002 18:48:56 +0200
Message-ID: <87lmffwfbb.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Edgar" == Edgar Toernig <froese@gmx.de> writes:

Edgar> David Woodhouse wrote:
>> 
>> What part of 'undefined behaviour' is so difficult for people to understand?

Edgar> The behaviour is undefined by the C standard.  But the mentioned
Edgar> pointer arithmetic is defined in the environment where it has been
Edgar> used.  GCC tries to optimize undefined C-standard behaviour.  And
Edgar> IMHO that's the point.  It may optimize defined behaviour and should
Edgar> not touch things undefined by the standard.

How do you imagine that "not touch" ? like "#if 0 ... #endif" ?

Edgar> PS: Hey, we are talking about C, the de luxe assembler! *g*

Standard is a standard. Broken code is broken code. Sometimes you can
get away with it, sometimes you can't and when you can't you fix the
code.  Or define your own standard and make a compiler implementing
it.

