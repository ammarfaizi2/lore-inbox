Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSHZMkr>; Mon, 26 Aug 2002 08:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSHZMkr>; Mon, 26 Aug 2002 08:40:47 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:63227 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318139AbSHZMkr>; Mon, 26 Aug 2002 08:40:47 -0400
Subject: Re: System freeze on 2.4.18 / 19 SMP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Holger Grosenick <h.grosenick@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208261436.44030.hgrosenick@web.de>
References: <200208261436.44030.hgrosenick@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 13:46:18 +0100
Message-Id: <1030365978.1437.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 13:36, Holger Grosenick wrote:

> module-list, all compiled for the current kernel release,
> no high memory support

The 2.4.19 kernel doesnt have any snd-* modules. This appears to be a
dump from something else - ALSA patches ?

> ---------------------------------------------------------------
> snd-pcm-oss            35364   0 (autoclean)
> snd-mixer-oss           9312   1 (autoclean)

I don't think ALSA is likely to be the cause however. Does it behave
stably running a non SMP kernel ?

