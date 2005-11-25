Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbVKYFED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbVKYFED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 00:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbVKYFED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 00:04:03 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:40388 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932682AbVKYFEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 00:04:01 -0500
Date: Fri, 25 Nov 2005 06:04:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: david singleton <dsingleton@mvista.com>,
       "David F. Carlson" <dave@chronolytics.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PI BUG with -rt13
Message-ID: <20051125050402.GA22230@elte.hu>
References: <20051118092909.GC4858@elte.hu> <20051118132137.GA5639@in.ibm.com> <20051118132715.GA3314@elte.hu> <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com> <20051118174454.GA2793@elte.hu> <43822480.6080301@mvista.com> <20051121212653.GA6143@elte.hu> <EDDB1894-5AFB-11DA-A840-000A959BB91E@mvista.com> <20051124145734.GA2717@elte.hu> <20051124202637.GB9098@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124202637.GB9098@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dinakar Guniguntala <dino@in.ibm.com> wrote:

> I just noticed with the above fix, Paul's testcase completely hangs up 
> and when killed I hit the BUG mentioned below. Till -rt13, this 
> testcase just ran to completion

does it still hang if you disable CONFIG_PARANOID_GENERIC_TIME in your 
.config?

	Ingo
