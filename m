Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275348AbTHSFGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 01:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275350AbTHSFGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 01:06:06 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:34248 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S275348AbTHSFGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 01:06:03 -0400
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1061267367.3f41a7a70f007@kolivas.org>
References: <1061261666.2094.15.camel@orbiter>
	 <200308191413.00135.kernel@kolivas.org> <1061267029.2900.54.camel@orbiter>
	 <1061267367.3f41a7a70f007@kolivas.org>
Content-Type: text/plain
Message-Id: <1061269559.5853.7.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 01:06:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There's a scheduler implementation dating pre 1970 that does this and I am led
> to believe someone is working on an implementation for perhaps 2.7

The first implementation is in 1962 with CTSS if i remember correctly.
Multics initially had something like that too.

 http://www.multicians.org/mult-sched.html

Anyway that's pretty standard CS stuff. Multi-level Queues with
feedback, exponentially longer timeslices with lower priority.

I was reading this recently, that's why i wondered why linux calculate
timeslice "inversed" versus what is proposed in theory.



