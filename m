Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292690AbSBZDTm>; Mon, 25 Feb 2002 22:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293487AbSBZDTb>; Mon, 25 Feb 2002 22:19:31 -0500
Received: from zero.tech9.net ([209.61.188.187]:46855 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292690AbSBZDTS>;
	Mon, 25 Feb 2002 22:19:18 -0500
Subject: Re: Submissions for 2.4.19-pre [x86 Syscall Optimizations
	(Alexander Khripin)]
From: Robert Love <rml@tech9.net>
To: Michael Cohen <me@ohdarn.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <20020225213255.2b403560.me@ohdarn.net>
In-Reply-To: <20020225210721.2ffa8fb1.me@ohdarn.net>
	<E16fXS2-0007SP-00@the-village.bc.nu> 
	<20020225213255.2b403560.me@ohdarn.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 25 Feb 2002 22:19:17 -0500
Message-Id: <1014693559.883.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-25 at 21:32, Michael Cohen wrote:
>
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> > Credit for the originator and an explanation would be helpful
>
> See Subject ^^ Alexander Khripin.  Looks to me like it improves latency
> quite a bit during syscalls.  I'm unable to find the exact mail but I
> believe I was referred to this particular patch by someone on lkml.

Eh?  The patch doesn't do anything but move movl ops around.  I suspect
the intention may to eliminate datapath stalls, which may be a fine
micro-optimization, but I think we need some numbers first ...

	Robert Love

