Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269837AbRHIPMG>; Thu, 9 Aug 2001 11:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269838AbRHIPL4>; Thu, 9 Aug 2001 11:11:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:517 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269837AbRHIPLl>; Thu, 9 Aug 2001 11:11:41 -0400
Subject: Re: Swapping for diskless nodes
To: abali@us.ibm.com (Bulent Abali)
Date: Thu, 9 Aug 2001 16:13:11 +0100 (BST)
Cc: dws@dirksteinberg.de (Dirk W. Steinberg),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <OF452D802E.BE93E657-ON85256AA3.004E8422@pok.ibm.com> from "Bulent Abali" at Aug 09, 2001 10:26:22 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UrUl-0007Rn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Last time I checked swapping over nbd required patching the network stack.
> Because swapping occurs when memory is low and when memory is low TCP
> doesn't do what you expect it to do...

Its a case of having sufficient memory in the atomic pools. Its possible to
do some ugly quick kernel hack to make the pool commit less likely to be a 
problem.

Ultimately its an insoluble problem, neither SunOS, Solaris or NetBSD are
infallible, they just never fail for any normal situation, and thats good
enough for me as a solution
