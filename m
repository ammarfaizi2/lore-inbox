Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSFXJL7>; Mon, 24 Jun 2002 05:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSFXJL6>; Mon, 24 Jun 2002 05:11:58 -0400
Received: from www.rulehinge.com ([196.28.7.66]:64425 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310190AbSFXJL5>; Mon, 24 Jun 2002 05:11:57 -0400
Date: Mon, 24 Jun 2002 09:34:15 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: pah@promiscua.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <20020624054959.19187.qmail@promiscua.org>
Message-ID: <Pine.LNX.4.44.0206240932220.2603-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jun 2002 pah@promiscua.org wrote:

> 	I've just found a bug (an unsignificant bug) in the panic() function!
> 	There's a possible buffer overflow if the formated string exceeds
> 1024 characters (I think that the problem is in all kernel releases).
> 	The problem is in the use of vsprintf() insted of vsnprintf()!
> 
> 	I know that this doesn't compromise any exploitation by an uid
> different than zero, but should be fixed in the case of panic()'s arguments
> exceeds the buffer limit (probably by an lkm or something like that) and
> cause (probably) a system crash.
> 

In that case there are quite a number of other places in the kernel which 
can be 'exploited' in various ways.

Cheers,
	Zwane

--
http://function.linuxpower.ca
		

