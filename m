Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318290AbSHZUJh>; Mon, 26 Aug 2002 16:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318292AbSHZUJh>; Mon, 26 Aug 2002 16:09:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:11518 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318290AbSHZUJg>; Mon, 26 Aug 2002 16:09:36 -0400
Subject: Re: [PATCH] hyperthreading scheduler improvement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1030392337.15007.413.camel@phantasy>
References: <1030392337.15007.413.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 21:15:08 +0100
Message-Id: <1030392908.2776.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 21:05, Robert Love wrote:
> Linus,
> 
> This patch implements a per-arch load balancing scheme for P4s to better
> balance across the virtual CPUs (e.g. prefer fully unused CPUs to a
> single available HT unit).  This is the same logic in 2.4-ac, 2.4-aa,
> etc.

This patch is disabled in -ac because it caused crashes for some users

