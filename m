Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbSLCVQq>; Tue, 3 Dec 2002 16:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266256AbSLCVQq>; Tue, 3 Dec 2002 16:16:46 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:63137 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266116AbSLCVQp>; Tue, 3 Dec 2002 16:16:45 -0500
Subject: Re: Reserving physical memory at boot time
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Duncan Sands <baldrick@wanadoo.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1021203160658.20996A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1021203160658.20996A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Dec 2002 21:58:04 +0000
Message-Id: <1038952684.11426.106.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 21:11, Richard B. Johnson wrote:
> If you need a certain page reserved at boot-time you are out-of-luck.

Wrong - you can specify the precise memory map of a box as well as use 
mem= to set the top of used memory. Its a painful way of marking a page
and it only works for a page the kernel isnt loaded into.

