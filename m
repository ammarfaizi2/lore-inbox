Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbUK0Tjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbUK0Tjc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 14:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbUK0Tjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 14:39:32 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:48791 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261310AbUK0Tjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 14:39:31 -0500
Date: Sat, 27 Nov 2004 20:39:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?ISO-8859-1?Q?jo=EBl?= Winteregg <joel.winteregg@eivd.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: client socket and source port selection
In-Reply-To: <1101576123.744.31.camel@debian>
Message-ID: <Pine.LNX.4.53.0411272039050.27610@yvahk01.tjqt.qr>
References: <1101576123.744.31.camel@debian>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>HI,
>
>For the project i'm doing, i must know how the Linux kernel allocate
>sockets source port (from the dynamic range of the (2**16)-1 ports). I
>looked on the Web but it's really hard to find the algoritm of the
>source port allocation...
>
>Someone maybe know how it's work or if there is a paper on the web that
>explain this source port selection ?

I think it starts at 1024 when it boots, and increments whenever a socket is
created.


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
