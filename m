Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129059AbRBTUec>; Tue, 20 Feb 2001 15:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129294AbRBTUeV>; Tue, 20 Feb 2001 15:34:21 -0500
Received: from www.wen-online.de ([212.223.88.39]:4878 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129059AbRBTUeL>;
	Tue, 20 Feb 2001 15:34:11 -0500
Date: Tue, 20 Feb 2001 21:33:38 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Probem with network performance 2.4.1
In-Reply-To: <Pine.LNX.3.95.1010220104511.29891A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0102202129260.1145-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Richard B. Johnson wrote:

> There is nothing in either the VXI/Bus driver or the the Ethernet
> driver that gives up the CPU, i.e., nobody calls schedule() in any
> (known) path.

Check out IKD.  Ktrace is wonderful for making such unknowns visible.

	-Mike

