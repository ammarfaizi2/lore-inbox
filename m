Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135468AbRDRXWr>; Wed, 18 Apr 2001 19:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135470AbRDRXWi>; Wed, 18 Apr 2001 19:22:38 -0400
Received: from et-gw.etinc.com ([207.252.1.2]:59404 "EHLO et-gw.etinc.com")
	by vger.kernel.org with ESMTP id <S135468AbRDRXWZ>;
	Wed, 18 Apr 2001 19:22:25 -0400
Message-Id: <5.0.2.1.0.20010418182619.0364e1d0@mail.etinc.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 18 Apr 2001 18:44:02 -0400
To: Matti Aarnio <matti.aarnio@zmailer.org>
From: Dennis <dennis@etinc.com>
Subject: Re: SMP in 2.4
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010418210546.W805@mea-ext.zmailer.org>
In-Reply-To: <5.0.2.1.0.20010418110702.03850d20@mail.etinc.com>
 <20010418211208.A1140@villain.home.ems.chel.su>
 <5.0.2.1.0.20010418110702.03850d20@mail.etinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:05 PM 04/18/2001, Matti Aarnio wrote:
>On Wed, Apr 18, 2001 at 11:08:22AM -0400, Dennis wrote:
> > Does 2.4 have something similar to spl levels or does it still require the
> > ridiculous MS-DOSish spin-locks to protect every bit of code?
>
>   Lets see -- (besides of MSDOS not having any sort of spinlocks), the
>   spl() is something out of VAX series of machines, and it really works
>   by presuming that there is some sort of priority leveling among irq
>   sources.


I was referring to the infamous CLI/STI combinations that are more 
analogous to spinlocks than anything you are talking about. spl levels are 
clean and transparent and have been doing a very nice job in  helping to 
avoid race conditions in real unix systems for quite some time now.

db


