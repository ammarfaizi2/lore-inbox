Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319151AbSH2NF7>; Thu, 29 Aug 2002 09:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319152AbSH2NF7>; Thu, 29 Aug 2002 09:05:59 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:37370
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319151AbSH2NF7>; Thu, 29 Aug 2002 09:05:59 -0400
Subject: Re: Laptops with SpeedStep technology.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steffen Persvold <sp@scali.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208291004550.1952-100000@sp-laptop.isdn.scali.no>
References: <Pine.LNX.4.44.0208291004550.1952-100000@sp-laptop.isdn.scali.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 29 Aug 2002 11:29:02 +0100
Message-Id: <1030616946.7290.98.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 09:13, Steffen Persvold wrote:
> Hi all,
> 
> Recently I got myself a Dell Inspiron 8200 with a Intel P4 Mobile wich has 
> SpeedStep technology. With power plugged in, this processor runs at 1.6 
> GHz and with battery only, 1.2 GHz. However I've found that the 
> /proc/cpuinfo doesn't show this and I was wondering if there were some 
> patches lying around before I began to look at this on my own.

cpufre handles this including switching processor speeds, fixing up
udelay and ensuring you dont get stuck at random boot speed

