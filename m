Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTCTQKV>; Thu, 20 Mar 2003 11:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261565AbTCTQKV>; Thu, 20 Mar 2003 11:10:21 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:62380 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S261530AbTCTQKU>; Thu, 20 Mar 2003 11:10:20 -0500
Date: Thu, 20 Mar 2003 17:21:10 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Srihari Vijayaraghavan <harisri@bigpond.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bottleneck on /dev/null
In-Reply-To: <Pine.LNX.4.53.0303201047500.4008@chaos>
Message-ID: <Pine.LNX.4.33.0303201720170.8831-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003, Richard B. Johnson wrote:

> unsigned long amount = 0L;

try 'volatile' to get the deviation down...

Tim

