Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275229AbTHSEXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 00:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275304AbTHSEXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 00:23:53 -0400
Received: from tomts17-srv.bellnexxia.net ([209.226.175.71]:16282 "EHLO
	tomts17-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S275229AbTHSEXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 00:23:52 -0400
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200308191413.00135.kernel@kolivas.org>
References: <1061261666.2094.15.camel@orbiter>
	 <200308191413.00135.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1061267029.2900.54.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 00:23:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You mean this the other way round, no? +nice means more nice.

sure you're right. and i know that timeslices get asssigned based on
static priority (which is nice value rescaled).

> For the most part, most tasks start at nice 0 so they pretty much all get the 
> same size timslices unless they get preempted.  The rest of the discussion 

i've read that tasks should start at higher dynamic priority with a
small timeslice (a priority boost for a starting task) then immediatly
drop to a lower priority if it use all it's timeslice.

> implemented theory. Changing it up and down by dynamic priority one way and 
> then the other wasn't helpful when I've tried it previously.

maybe it's because the timeslice calculation is reversed?


