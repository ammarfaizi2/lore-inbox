Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317297AbSFGPEq>; Fri, 7 Jun 2002 11:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSFGPEp>; Fri, 7 Jun 2002 11:04:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:44797 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317297AbSFGPEo>; Fri, 7 Jun 2002 11:04:44 -0400
Subject: Re: [PATCH] 2.4.19-pre10 bug in disable_APIC_timer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joe Korty <joe.korty@ccur.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <200206071449.OAA16511@rudolph.ccur.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Jun 2002 16:58:28 +0100
Message-Id: <1023465508.25523.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-07 at 15:49, Joe Korty wrote:
> 
> I am calling it from some cpu shielding code I've written and am
> debugging.

So the __init isnt actually a bug. It might be an appropriate change if
your code ever becomes part of the main tree thats all

