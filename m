Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbVKYNVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbVKYNVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 08:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbVKYNVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 08:21:23 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:64183 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932685AbVKYNVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 08:21:22 -0500
Date: Fri, 25 Nov 2005 18:57:08 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: david singleton <dsingleton@mvista.com>,
       "David F. Carlson" <dave@chronolytics.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PI BUG with -rt13
Message-ID: <20051125132708.GA3954@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051118132137.GA5639@in.ibm.com> <20051118132715.GA3314@elte.hu> <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com> <20051118174454.GA2793@elte.hu> <43822480.6080301@mvista.com> <20051121212653.GA6143@elte.hu> <EDDB1894-5AFB-11DA-A840-000A959BB91E@mvista.com> <20051124145734.GA2717@elte.hu> <20051124202637.GB9098@in.ibm.com> <20051125050402.GA22230@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051125050402.GA22230@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2005 at 06:04:02AM +0100, Ingo Molnar wrote:
> 
> * Dinakar Guniguntala <dino@in.ibm.com> wrote:
> 
> > I just noticed with the above fix, Paul's testcase completely hangs up 
> > and when killed I hit the BUG mentioned below. Till -rt13, this 
> > testcase just ran to completion
> 
> does it still hang if you disable CONFIG_PARANOID_GENERIC_TIME in your 
> .config?

Disabling CONFIG_PARANOID_GENERIC_TIME does not help. I get the same
hang. Just got my kgdb setup. Hopefully I should have more info

	-Dinakar
