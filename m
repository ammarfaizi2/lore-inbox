Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318385AbSGaOM6>; Wed, 31 Jul 2002 10:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318386AbSGaOM6>; Wed, 31 Jul 2002 10:12:58 -0400
Received: from noc.easyspace.net ([62.254.202.67]:22278 "EHLO
	noc.easyspace.net") by vger.kernel.org with ESMTP
	id <S318385AbSGaOM5>; Wed, 31 Jul 2002 10:12:57 -0400
Date: Wed, 31 Jul 2002 15:16:05 +0100
From: Sam Vilain <sam@vilain.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: davidsen@tmr.com, jamagallon@able.es, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, habanero@us.ibm.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
In-Reply-To: <Pine.LNX.4.44L.0207310940350.23404-100000@imladris.surriel.com>
References: <Pine.LNX.3.96.1020730230654.6974E-100000@gatekeeper.tmr.com>
	<Pine.LNX.4.44L.0207310940350.23404-100000@imladris.surriel.com>
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: NErb*2NY4\th?$s.!!]_9le_WtWE'b4;dk<5ot)OW2hErS|tE6~D3errlO^fVil?{qe4Lp_m\&Ja!;>%JqlMPd27X|;b!GH'O.,NhF*)e\ln4W}kFL5c`5t'9,(~Bm_&on,0Ze"D>rFJ$Y[U""nR<Y2D<b]&|H_C<eGu?ncl.w'<
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20020731141606.093752B65@hofmann>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> wrote:

> Having code this readable is pretty much essential for
> maintenance, too.
> I wouldn't mind if every time I code or patch something
> that isn't up to the reading standard of Mr. Magallon's
> code somebody would raise his hand and/or LART me, until
> the code is easily readable.

The GNU coding standards make some very sensible comments on this
subject. A very good read;

  http://www.gnu.org/prep/standards_24.html

I find it interesting that a large quantity of the kernel and C
library source code I have come across recently has no comments (with
the exception of the O(1) scheduler, very nice).  At the very least, I
think every function should have a comment listing all of its input
variables and what they mean, along with a rough idea of what the
function does, and what it returns, along with any assumptions.  It
would make the code a *lot* easier for programmers with less than guru
levels of knowledge to understand and hack on.
--
   Sam Vilain, sam@vilain.net     WWW: http://sam.vilain.net/
    7D74 2A09 B2D3 C30F F78E      GPG: http://sam.vilain.net/sam.asc
    278A A425 30A9 05B5 2F13

  Its not the size of the ship, its the size of the waves.
LITTLE RICHARD
