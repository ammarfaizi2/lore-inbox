Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbUAGPNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 10:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUAGPNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 10:13:11 -0500
Received: from mercury.sdinet.de ([193.103.161.30]:52897 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S265580AbUAGPNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 10:13:08 -0500
Date: Wed, 7 Jan 2004 16:13:04 +0100 (CET)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Lorenzo Hernandez Garcia-Hierro <lorenzohgh@nsrg-security.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems in 2.4.18 with madwifi
In-Reply-To: <1073486703.850.24.camel@zeus>
Message-ID: <Pine.LNX.4.58.0401071610480.708@mercury.sdinet.de>
References: <1073486703.850.24.camel@zeus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Lorenzo Hernandez Garcia-Hierro wrote:

> I am having trouble on a madwifi installation :
>
> When compiling wlan.o it tries to get the net/iw_handler.h but i am
> running Debian with 2.4.18 ( i can boot with 2.4.18 , 2.4.22 and 2.6.0
> ).
>
> Where is the problem ?

> if_ieee80211wireless.c:54: net/iw_handler.h: No such file or directory

You need a newer kernel than 2.4.18 - include/net/iw_handler.h is part of
2.4.23, .24, and perhaps .22 or even older.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
