Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289044AbSAZJOM>; Sat, 26 Jan 2002 04:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289047AbSAZJOE>; Sat, 26 Jan 2002 04:14:04 -0500
Received: from pc3-redb4-0-cust131.bre.cable.ntl.com ([213.106.223.131]:1525
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S289044AbSAZJNz>; Sat, 26 Jan 2002 04:13:55 -0500
Date: Sat, 26 Jan 2002 09:13:51 +0000
From: Mark Zealey <mark@zealos.org>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020126091351.GA13468@itsolve.co.uk>
In-Reply-To: <3C513CD8.B75B5C42@aitel.hist.no> <20020126030841.C5730@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020126030841.C5730@kushida.apsleyroad.org>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.17-wli2 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2002 at 03:08:41AM +0000, Jamie Lokier wrote:

> Helge Hafting wrote:
> > Why would anyone want to write   if (X==false) or if (X==true) ?
> > It is the "beginner's mistake" way of writing code.  Then people learn,
> > and write if (X) or if (!X).  Comparing to true/false is silly.
> > Nobody writes  if ( (a==b) == true) so why do it in the simpler cases?
> 
> I usually without the == in these cases:
> 
>   if (pointer)  // test for non-0.

Huh? I thought we were talking about C here, // in C is an abomination, use /*
*/ :-)

> Just to break that rule, however, if p were a pointer and x were an
> integer, I would write:
> 
>   x = (p != 0);

Heard about NULL ?

> rather than
> 
>   x = p;

Because that would give a compile error...

-- 

Mark Zealey
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
