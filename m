Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316962AbSFZV7t>; Wed, 26 Jun 2002 17:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316964AbSFZV7t>; Wed, 26 Jun 2002 17:59:49 -0400
Received: from web30.achilles.net ([209.151.1.2]:61587 "EHLO
	web30.achilles.net") by vger.kernel.org with ESMTP
	id <S316962AbSFZV7s>; Wed, 26 Jun 2002 17:59:48 -0400
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
From: Robert Love <rml@tech9.net>
To: Bongani <bonganilinux@mweb.co.za>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Alexandre Pereira Nunes <alex@PolesApart.dhs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1025125214.1911.40.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org> 
	<20020626204721.GK22961@holomorphy.com> 
	<1025125214.1911.40.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jun 2002 17:54:13 -0400
Message-Id: <1025128477.1144.3.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-26 at 17:00, Bongani wrote:
> IIRC the preemptive patch is now part of -ac

The preemptive kernel is not part of 2.4-ac.

Btw, fwiw, I do not think this problem has anything to do with
preemption.  The "exited with preempt_count" message just means the task
exited with preemption disabled.  It is not a problem if the task died
abnormally.

	Robert Love

