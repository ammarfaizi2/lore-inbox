Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275346AbTHSE36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 00:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275347AbTHSE3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 00:29:33 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:54922
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S275346AbTHSE3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 00:29:30 -0400
Message-ID: <1061267367.3f41a7a70f007@kolivas.org>
Date: Tue, 19 Aug 2003 14:29:27 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Eric St-Laurent <ericstl34@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
References: <1061261666.2094.15.camel@orbiter>  <200308191413.00135.kernel@kolivas.org> <1061267029.2900.54.camel@orbiter>
In-Reply-To: <1061267029.2900.54.camel@orbiter>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric St-Laurent <ericstl34@sympatico.ca>:

> i've read that tasks should start at higher dynamic priority with a
> small timeslice (a priority boost for a starting task) then immediatly
> drop to a lower priority if it use all it's timeslice.

There's a scheduler implementation dating pre 1970 that does this and I am led
to believe someone is working on an implementation for perhaps 2.7

> 
> > implemented theory. Changing it up and down by dynamic priority one way and
> 
> > then the other wasn't helpful when I've tried it previously.
> 
> maybe it's because the timeslice calculation is reversed?

In my email I said I tried it both ways.

Con
