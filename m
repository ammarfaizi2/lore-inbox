Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbRETWnJ>; Sun, 20 May 2001 18:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262261AbRETWm7>; Sun, 20 May 2001 18:42:59 -0400
Received: from t2.redhat.com ([199.183.24.243]:2805 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262258AbRETWmq>; Sun, 20 May 2001 18:42:46 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3B082672.63D1F44E@gmx.net> 
In-Reply-To: <3B082672.63D1F44E@gmx.net> 
To: Jens Haerer <jens.haerer@gmx.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: waitqueue problem on 2.4.3 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 May 2001 23:42:32 +0100
Message-ID: <25249.990398552@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can't see anything immediately wrong with your code - make sure you're 
compiling against the source for the kernel you're running, with the same 
options enabled. 

In general, though, you shouldn't be using any of the sleep_on() functions 
if you care about the fact that you'll miss wakeup events.

--
dwmw2


