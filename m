Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbSAZQcP>; Sat, 26 Jan 2002 11:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbSAZQcF>; Sat, 26 Jan 2002 11:32:05 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:6278 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S285338AbSAZQbu>; Sat, 26 Jan 2002 11:31:50 -0500
Date: Sat, 26 Jan 2002 16:27:47 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: =?iso-8859-1?Q?G=E1bor_L=E9n=E1rt?= <lgb@lgb.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020126162747.A6724@kushida.apsleyroad.org>
In-Reply-To: <3C513CD8.B75B5C42@aitel.hist.no> <20020126030841.C5730@kushida.apsleyroad.org> <20020126105121.GA18223@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020126105121.GA18223@vega.digitel2002.hu>; from lgb@lgb.hu on Sat, Jan 26, 2002 at 11:51:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gábor Lénárt wrote:
> Khmmm please enlighten me ...
> 
> >   if (X == true && ptr && *ptr > 1)
> 
> Why? Simply use for example type 'char' as boolean value. Let's say
> 0 means false and other value is true.
> 
> So:
> 
> if (x) printf("true");
> or
> if (!x) printf("false");
> 
> Why do you want to overcomplicate?

If the variable holds a boolean in the C language, fair enough but if
it's being used as a range in a truth-value system of _another_
language, i.e. it simply _represents_ a truth value, I would write it
differently.

If it were a theorem proving paper, the different kinds of variable
would have a different font or colour :-)

> x=a>b;
> if (x) printf("A is greater than B");
> 
> ONE thing which is best in C is the less strictly type rules eg you
> can use 'char' to store eg c='A' or c=2.

You seem to have missed the point.  We _know_ the C language rules.  I
agree that non-strict typeing is quite useful, although C is in fact
quite strict.  Lisp has far less strict typing :-)

> Hey guys, C was designed to write an OS it's not something other ...

Perhaps, but it's pretty useful for something other.

-- Jamie
