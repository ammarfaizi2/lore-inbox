Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273926AbRI0VgO>; Thu, 27 Sep 2001 17:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273928AbRI0VgD>; Thu, 27 Sep 2001 17:36:03 -0400
Received: from femail40.sdc1.sfba.home.com ([24.254.60.34]:157 "EHLO
	femail40.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S273926AbRI0VgA>; Thu, 27 Sep 2001 17:36:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Sean Swallow <sean@swallow.org>, <linux-kernel@vger.kernel.org>
Subject: Re: AMD viper chipset and UDMA100
Date: Thu, 27 Sep 2001 14:36:25 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0109271419430.32187-100000@lsd.nurk.org>
In-Reply-To: <Pine.LNX.4.33.0109271419430.32187-100000@lsd.nurk.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010927213620.QXMB23807.femail40.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 September 2001 02:26 pm, Sean Swallow wrote:
> List,
>
> I just got a tyan tiger w/ the AMD Viper chipset on it. For some
> reason Linux will only set the onboard (AMD viper) chains to UDMA33.
>
> I'm using linux 2.4.9, and I have also tried 2.4.10. Is there a
> limitation to the AMD Viper driver?
>
> PS. The cables (2) are BRAND new ata100 cables.
>
> cheers,

Welcome to hell.
I belive the solution is to enable the option "IGNORE word93 Validation 
BITS" at the bottom of the "IDE, ATA and ATAPI Block Devices" menu 
accessable in "ATA/IDE/MFM/RLL support"
