Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSF0Pqr>; Thu, 27 Jun 2002 11:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSF0Pqq>; Thu, 27 Jun 2002 11:46:46 -0400
Received: from web30.achilles.net ([209.151.1.2]:30699 "EHLO
	web30.achilles.net") by vger.kernel.org with ESMTP
	id <S316106AbSF0Pqp>; Thu, 27 Jun 2002 11:46:45 -0400
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Bongani <bonganilinux@mweb.co.za>,
       Alexandre Pereira Nunes <alex@PolesApart.dhs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020627005431.GM22961@holomorphy.com>
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org>
	<20020626204721.GK22961@holomorphy.com>
	<1025125214.1911.40.camel@localhost.localdomain>
	<1025128477.1144.3.camel@icbm>  <20020627005431.GM22961@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 Jun 2002 11:40:39 -0400
Message-Id: <1025192465.1084.3.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-26 at 20:54, William Lee Irwin III wrote:

> Well, my concern here is for the pte_chain_lock() / pte_chain_unlock()
> bits. Teaching them about preemption should be all that's needed there.

The newest patch should have the code I shared with you.  So we are OK,
no?

	Robert Love

