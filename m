Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbTBFO4L>; Thu, 6 Feb 2003 09:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTBFO4L>; Thu, 6 Feb 2003 09:56:11 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:20487 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267334AbTBFO4K>; Thu, 6 Feb 2003 09:56:10 -0500
Date: Thu, 6 Feb 2003 18:05:20 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: add framework for ndelay (nanoseconds)
Message-ID: <20030206180520.A21123@jurassic.park.msu.ru>
References: <200302040533.h145Xqq19457@hera.kernel.org> <Pine.GSO.4.21.0302051533320.16681-100000@vervain.sonytel.be> <20030206174944.A17905@jurassic.park.msu.ru> <1044546783.10374.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1044546783.10374.4.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 06, 2003 at 03:53:05PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 03:53:05PM +0000, Alan Cox wrote:
> Why waste 500nS every IDE command as opposed to doing the job right ? The initial
> ndelay() is a quick implementation. If you don't like it implement a better one,
> if your box isnt fast implement it as udelay.

Ok, I see. Probably i386 and others need additional shifts to improve
precision.
BTW, on alpha it's non-issue, despite that initial overhead.

Ivan.
