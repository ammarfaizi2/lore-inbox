Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbSAZKvr>; Sat, 26 Jan 2002 05:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbSAZKvh>; Sat, 26 Jan 2002 05:51:37 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:61928 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S276424AbSAZKv1>; Sat, 26 Jan 2002 05:51:27 -0500
Date: Sat, 26 Jan 2002 11:51:22 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020126105121.GA18223@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <3C513CD8.B75B5C42@aitel.hist.no> <20020126030841.C5730@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020126030841.C5730@kushida.apsleyroad.org>
User-Agent: Mutt/1.3.27i
X-Operating-System: vega Linux 2.4.17 i686
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
>   if (condition)
>   if (condition-valued-variable)
> 
> but not in these (although I am not very consistent):

Khmmm please enlighten me ...

>   if (X == true && ptr && *ptr > 1)

Why? Simply use for example type 'char' as boolean value. Let's say
0 means false and other value is true.

So:

if (x) printf("true");

or

if (!x) printf("false");

Why do you want to overcomplicate?

Even:

x=a>b;
if (x) printf("A is greater than B");

ONE thing which is best in C is the less strictly type rules eg you
can use 'char' to store eg c='A' or c=2.
Hey guys, C was designed to write an OS it's not something other ...

- Gábor
