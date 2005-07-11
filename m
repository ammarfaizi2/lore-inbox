Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVGKSi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVGKSi7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVGKSg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:36:26 -0400
Received: from dvhart.com ([64.146.134.43]:62133 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261640AbVGKSfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:35:37 -0400
Date: Mon, 11 Jul 2005 11:35:33 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Lee Revell <rlrevell@joe-job.com>, randy_dunlap <rdunlap@xenotime.net>
Cc: akpm@osdl.org, arjan@infradead.org, azarah@nosferatu.za.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <174460000.1121106933@flay>
In-Reply-To: <1120944358.6488.90.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org> <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe> <1120933916.3176.57.camel@laptopd505.fenrus.org> <1120934163.6488.72.camel@mindpipe> <20050709121212.7539a048.akpm@osdl.org> <1120936561.6488.84.camel@mindpipe> <20050709133036.11e60a3c.rdunlap@xenotime.net> <1120944358.6488.90.camel@mindpipe>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Saturday, July 09, 2005 17:25:58 -0400 Lee Revell <rlrevell@joe-job.com> wrote:

> On Sat, 2005-07-09 at 13:30 -0700, randy_dunlap wrote:
>> | Then the owners of such machines can use HZ=250 and leave the default
>> | alone.  Why should everyone have to bear the cost?
>> 
>> indeed, why should everyone have to have 1000 timer interrupts per second?
> 
> So why waste everyone's time with CONFIG_HZ when there are working
> dynamic tick solutions out there?  It's just bad release engineering.

So on the flip side of this ... why are you complaining about it, instead
of working on the real fix? ;-) 

Having HZ=1000 seems to just be a band-aid for not having sub-hz timers ...
it causes unnecessary overhead for other subsytems.

M.
