Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262787AbSIPSkX>; Mon, 16 Sep 2002 14:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSIPSkX>; Mon, 16 Sep 2002 14:40:23 -0400
Received: from dsl-213-023-040-192.arcor-ip.net ([213.23.40.192]:11401 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262787AbSIPSkW>;
	Mon, 16 Sep 2002 14:40:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Mon, 16 Sep 2002 20:45:22 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209161231520.10048-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209161231520.10048-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17r0s7-0000KS-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 20:35, Thunder from the hill wrote:
> !assert(typeof((fool)->next) == typeof(fool));

You meant:

	assert(typeof((fool)->next) != typeof(fool));

-- 
Daniel
