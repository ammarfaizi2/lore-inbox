Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSGWGJH>; Tue, 23 Jul 2002 02:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317760AbSGWGJH>; Tue, 23 Jul 2002 02:09:07 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:32272 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S316682AbSGWGJG>; Tue, 23 Jul 2002 02:09:06 -0400
Date: Tue, 23 Jul 2002 16:12:12 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: read/recv sometimes returns EAGAIN instead of EINTR on SMP
In-Reply-To: <20020723010437.GC2292@conectiva.com.br>
Message-ID: <Mutt.LNX.4.44.0207231528580.17462-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Arnaldo Carvalho de Melo wrote:

> Em Tue, Jul 23, 2002 at 07:56:39AM +0400, kuznet@ms2.inr.ac.ru escreveu:
> > Second, I never understood what is the problem with SIGURG.
> > That's why it lives untouched.
> 
> Andi once described it to me and recently he described it to jamesm that
> has done work on this area, but I think he is busy now and haven't had a
> chance to finish, James?
> 

I'm not sure it's the same issue.  All I've been doing is consolidating 
the existing code and storing user credentials so they are checked at 
SIGURG delivery time.  This would not change the semantics of syscall 
return values or signal delivery order.


- James
-- 
James Morris
<jmorris@intercode.com.au>



