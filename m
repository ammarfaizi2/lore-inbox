Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbSKOOpE>; Fri, 15 Nov 2002 09:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbSKOOpE>; Fri, 15 Nov 2002 09:45:04 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:13998 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266347AbSKOOpE>; Fri, 15 Nov 2002 09:45:04 -0500
Subject: Re: /proc/stat interface and 32bit jiffies / kernel_stat
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Elrond@Wunder-Nett.org
In-Reply-To: <20021115142244.GG5957@darkside.ddts.net>
References: <20021115142244.GG5957@darkside.ddts.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Nov 2002 15:18:20 +0000
Message-Id: <1037373500.19971.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 14:22, Mario 'BitKoenig' Holbe wrote:
> Btw... Could anybody please explain me the problems to
> expect while a jiffies overflow? Would a kernel possibly
> survive this at all and if, what's the chance to? :)

The kernel uses time_before/time_after functions which know about the
wrapping of time so it should all go ok

