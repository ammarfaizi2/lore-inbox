Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275330AbTHSEGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 00:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275332AbTHSEGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 00:06:21 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:25994
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S275330AbTHSEGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 00:06:21 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Eric St-Laurent <ericstl34@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
Date: Tue, 19 Aug 2003 14:13:00 +1000
User-Agent: KMail/1.5.3
References: <1061261666.2094.15.camel@orbiter>
In-Reply-To: <1061261666.2094.15.camel@orbiter>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308191413.00135.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 12:54, Eric St-Laurent wrote:
> currently, nicer tasks (nice value toward -20) get larger timeslices,
> and less nice tasks (nice value toward 19) get small timeslices.

You mean this the other way round, no? +nice means more nice.

For the most part, most tasks start at nice 0 so they pretty much all get the 
same size timslices unless they get preempted.  The rest of the discussion 
you can debate to the end of the earth, but application counts once you've 
implemented theory. Changing it up and down by dynamic priority one way and 
then the other wasn't helpful when I've tried it previously.

Con

