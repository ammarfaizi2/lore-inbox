Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSHZJtn>; Mon, 26 Aug 2002 05:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318031AbSHZJtn>; Mon, 26 Aug 2002 05:49:43 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:5883 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318028AbSHZJtm>; Mon, 26 Aug 2002 05:49:42 -0400
Subject: Re: PROBLEM:  conflict between apm and system clock on Inspiron 8100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mike heffner <mdheffner@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020826081431.44853.qmail@web40207.mail.yahoo.com>
References: <20020826081431.44853.qmail@web40207.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 10:55:53 +0100
Message-Id: <1030355753.16767.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 09:14, mike heffner wrote:
> the switch apm=allow_int, but that showed no change. 
> I have found some vague (don't mention apm) references
> to this problem on the web, but no solutions.  Does
> anyone understand this problem?

The 8100 seems to turn off interrupts itself and read the battery very
slowly causing lost ticks (its taking > 1/100th of a second to do the
read). 
