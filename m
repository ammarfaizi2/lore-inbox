Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280149AbRJaK5F>; Wed, 31 Oct 2001 05:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280147AbRJaK44>; Wed, 31 Oct 2001 05:56:56 -0500
Received: from [195.66.192.167] ([195.66.192.167]:34062 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280150AbRJaK4h>; Wed, 31 Oct 2001 05:56:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] Smbfs + preempt on 2.4.10
Date: Wed, 31 Oct 2001 12:55:40 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15yXWU-0006EF-00@the-village.bc.nu>
In-Reply-To: <E15yXWU-0006EF-00@the-village.bc.nu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01103112554004.00794@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 October 2001 11:57, you wrote:
> > I can't find where that write() func ptr is coming
> > (tracked it to tty->ldisc.write, but failed to find out
> > where that field is assigned to).
> > Somebody enlighten me...
>
> For the vesa fb scrolling case you probably want to put your own scheduling
> points into the vesafb copying

You are right but I couldn't find where vesafb copying routine lives in the 
tree :-(  Perhaps I should try harder digging...
--
vda
