Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318130AbSIAWH0>; Sun, 1 Sep 2002 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSIAWH0>; Sun, 1 Sep 2002 18:07:26 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:63240
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318130AbSIAWHZ>; Sun, 1 Sep 2002 18:07:25 -0400
Subject: Re: question on spinlocks
From: Robert Love <rml@tech9.net>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Oliver Neukum <oliver@neukum.name>, Ralf Baechle <ralf@uni-koblenz.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209011607380.3234-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0209011607380.3234-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Sep 2002 18:11:55 -0400
Message-Id: <1030918315.11553.3128.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-01 at 18:09, Thunder from the hill wrote:

> IMHO you might even ask "How do I start a car when I don't have the keys?"
> 
> You might find a way, but it's not desired. Are you sure you want to 
> reschedule in an interrupt handler? If it's none, are you sure you want to 
> disable interrupts?

I do not think he is in an interrupt handler.

If he were, the system would die when he called schedule().

	Robert Love

