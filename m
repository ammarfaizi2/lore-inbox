Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318138AbSHQT1N>; Sat, 17 Aug 2002 15:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318706AbSHQT1N>; Sat, 17 Aug 2002 15:27:13 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19954 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318138AbSHQT1N>; Sat, 17 Aug 2002 15:27:13 -0400
Subject: Re: Linux 2.4.20-pre3 (Athlon prefetch dibbles)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alastair Stevens <alastair@altruxsolutions.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1029575099.4601.7.camel@dolphin.entropy.net>
References: <1029575099.4601.7.camel@dolphin.entropy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Aug 2002 20:30:07 +0100
Message-Id: <1029612607.4647.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-17 at 10:04, Alastair Stevens wrote:
> Since the "hacky" Athlon/AGP fix has now been removed again, what's the
> status of the "clean" fix? And while I'm at it, did the hacky one cause
> any specific problems?

-ac has it removed. I didn't know Marcelo had it removed. Andi Kleen has
a patch for doing most of the right things without trashing performance.
That may be what Marcelo merged. It fixed AGP but not O_SYNC mmap I
believe


