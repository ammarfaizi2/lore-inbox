Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318316AbSG3QBe>; Tue, 30 Jul 2002 12:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318317AbSG3QBe>; Tue, 30 Jul 2002 12:01:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:59118 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318316AbSG3QBe>; Tue, 30 Jul 2002 12:01:34 -0400
Subject: Re: Clearing the terminal portably
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D46AEEF.mail2H19I8Z8@viadomus.com>
References: <3D46AEEF.mail2H19I8Z8@viadomus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 18:21:02 +0100
Message-Id: <1028049662.7886.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 16:21, DervishD wrote:
>     Hi all :))
> 
>     I want to clear a terminal more or less 'portably' but without
> using curses (that's forced). I must work at least for the TERM
> 'linux' and it would be great if it works on all linux platforms. The
> portability is intended *only* within different linux archs, not
> more.
> 
>     I currently write 'ESC c' to the terminal and it works (it is the
> reset code for a 'linux' TERM), but I wonder if there is a better way.

Not really a kernel question. Take a look at tput terminfo ncurses
and/or slang

