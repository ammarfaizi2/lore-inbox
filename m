Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262193AbSJJT55>; Thu, 10 Oct 2002 15:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262182AbSJJTzz>; Thu, 10 Oct 2002 15:55:55 -0400
Received: from codepoet.org ([166.70.99.138]:49111 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S262150AbSJJTzK>;
	Thu, 10 Oct 2002 15:55:10 -0400
Date: Thu, 10 Oct 2002 14:00:54 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marco Colombo <marco@esi.it>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021010200053.GA24362@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marco Colombo <marco@esi.it>, Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0210092045195.22735-100000@imladris.surriel.com> <Pine.LNX.4.44.0210101207140.26363-100000@Megathlon.ESI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210101207140.26363-100000@Megathlon.ESI>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 10, 2002 at 12:33:07PM +0200, Marco Colombo wrote:
> True, but either you include kernel headers from user apps, or wait for
> glibc (or [whatever]libc) to catch up, or do something like this:
> 
> 	#define O_STREAMING 04000000
> 
> 	fd = open(file, ... | O_STREAMING);
> 
> (quoted directly from one of Robert's messages).

I dunno about glibc, but I stuck support for O_STREAMING into 
uClibc last night...  :)

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
