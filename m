Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262514AbREXXT5>; Thu, 24 May 2001 19:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262516AbREXXTr>; Thu, 24 May 2001 19:19:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12297 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262514AbREXXTc>; Thu, 24 May 2001 19:19:32 -0400
Subject: Re: [CHECKER] free bugs in 2.4.4 and 2.4.4-ac8
To: carlson@sibyte.com
Date: Fri, 25 May 2001 00:16:29 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        engler@csl.Stanford.EDU (Dawson Engler), linux-kernel@vger.kernel.org
In-Reply-To: <0105241559150L.01510@plugh.sibyte.com> from "Justin Carlson" at May 24, 2001 03:55:32 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1534LF-0005nC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Error --->
> > >         	       p, p->RIOHosts, p->RIOPortp, rio_termios, rio_termios);
> > 
> > Not a bug - you need to teach your code that printf has formats that print the
> > value of a pointer not dereference it
> > 
> 
> Take another look.  p is potentially bogus here, meaning those p->RIOHosts and
> p->RIOPortp references are bad.

True - fixed
