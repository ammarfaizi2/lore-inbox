Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264406AbTLBVvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 16:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbTLBVvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 16:51:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:64485 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264406AbTLBVvo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 16:51:44 -0500
Subject: Re: APM Suspend Problem
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031127062057.GA31974@nasledov.com>
References: <20031127062057.GA31974@nasledov.com>
Content-Type: text/plain
Organization: 
Message-Id: <1070401451.23568.587.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Dec 2003 13:44:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-26 at 22:20, Misha Nasledov wrote:
> Since about 2.6.0-test9, my ThinkPad T21 no longer suspends with APM. I had

Just wanted to add a "me too" to this. 

I too am having trouble w/ APM suspend/resume with 2.6.0-testX on my TP
T20. I've narrowed it down to the 3c59x PCMCIA card I'm using. If the
card is present in the system when it suspends, the system will not
properly resume (disk fails to spin up all the way). Without the 3c59x
card, the system will suspend and resume properly. 2.4 works like a
charm. 

config and dmesg can be found in osdl bug #1569.

http://bugme.osdl.org/show_bug.cgi?id=1569

thanks
-john


