Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317083AbSFFShU>; Thu, 6 Jun 2002 14:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSFFSg2>; Thu, 6 Jun 2002 14:36:28 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:56569 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317091AbSFFSeW>; Thu, 6 Jun 2002 14:34:22 -0400
Subject: Re: [PATCH] Futex Asynchronous Interface
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        frankeh@watson.ibm.com
In-Reply-To: <Pine.LNX.4.44.0206060930240.5920-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Jun 2002 20:27:42 +0100
Message-Id: <1023391662.23013.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-06 at 17:36, Linus Torvalds wrote:
> You have a damn mutex system call, don't introduce mode crap in /dev.
> 
> Do we create pipes by opening /dev/pipe? No. Do we have major and minor
> numbers for sockets and populate /dev with them? No. And as a result,
> there has _never_ been any sysadmin problems with either.

Its a bitch trying to create sockets in shell scripts isnt it. I wonder
if there is a connection 8)

Alan
