Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267694AbTAHDoM>; Tue, 7 Jan 2003 22:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267695AbTAHDoM>; Tue, 7 Jan 2003 22:44:12 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:14744 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267694AbTAHDoM>;
	Tue, 7 Jan 2003 22:44:12 -0500
Subject: Re: [PATCH] linux-2.5.54_delay-cleanup_A0
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301071927190.1892-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0301071927190.1892-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1041997716.1050.76.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 07 Jan 2003 19:48:36 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 19:29, Linus Torvalds wrote:
> Wouldn't it be saner to initialize the timer to something that can at 
> least do estimated loops, and then just unconditionally do
> 
> 	timer->delay(..);
> 
> instead?

Basically a default timer_null structure? Sure that can be done (I think
others have suggested this as well, but I've just not had the time to
get around to it). I'll see if I can scratch that out quickly and
resend. 

thanks for the feedback!
-john



