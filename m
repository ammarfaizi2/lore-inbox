Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291641AbSBAJmF>; Fri, 1 Feb 2002 04:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291642AbSBAJlz>; Fri, 1 Feb 2002 04:41:55 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:35719 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S291641AbSBAJlu>; Fri, 1 Feb 2002 04:41:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Stefani Seibold <stefani@seibold.net>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: fix for shared interrupt in serial i/o
Date: Fri, 1 Feb 2002 10:40:29 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16WQOh-04YPE8C@fmrl10.sul.t-online.com> <20020131234748.A1967@flint.arm.linux.org.uk>
In-Reply-To: <20020131234748.A1967@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16WaCP-1ycR8qC@fmrl02.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forget my last posting, the shared serial irq handler works fine. The 
state i had described will never happens.
So, the only good thing in this patch is the low_latency modification 
and the test of the ier shadow register in the receive_chars(), 
transmit_chars() and check_modem_status().
Sorry, next time i will think more about it, bevore posting it.
Greetings,
Stefani
