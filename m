Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318353AbSHZUgS>; Mon, 26 Aug 2002 16:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSHZUgS>; Mon, 26 Aug 2002 16:36:18 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:41478
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318353AbSHZUgS>; Mon, 26 Aug 2002 16:36:18 -0400
Subject: Re: [PATCH] hyperthreading scheduler improvement
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1030394129.2776.23.camel@irongate.swansea.linux.org.uk>
References: <1030392337.15007.413.camel@phantasy> 
	<1030392908.2776.17.camel@irongate.swansea.linux.org.uk> 
	<1030393512.15007.435.camel@phantasy> 
	<1030394129.2776.23.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Aug 2002 16:40:28 -0400
Message-Id: <1030394428.905.442.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 16:35, Alan Cox wrote:

> It crashes on P4 systems

Hm, we must be doing some silly, then...

Similar logic is even in the stock 2.4 scheduler, in
reschedule_idle()...


	Robert Love

