Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbVKXU1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbVKXU1N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 15:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVKXU1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 15:27:13 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:5570 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751399AbVKXU04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 15:26:56 -0500
Date: Fri, 25 Nov 2005 02:02:50 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: david singleton <dsingleton@mvista.com>,
       "David F. Carlson" <dave@chronolytics.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PI BUG with -rt13
Message-ID: <20051124203250.GA9086@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051118092909.GC4858@elte.hu> <20051118132137.GA5639@in.ibm.com> <20051118132715.GA3314@elte.hu> <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com> <20051118174454.GA2793@elte.hu> <43822480.6080301@mvista.com> <20051121212653.GA6143@elte.hu> <EDDB1894-5AFB-11DA-A840-000A959BB91E@mvista.com> <20051124145734.GA2717@elte.hu> <20051124202637.GB9098@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124202637.GB9098@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2005 at 01:56:37AM +0530, Dinakar Guniguntala wrote:
> On Thu, Nov 24, 2005 at 03:57:34PM +0100, Ingo Molnar wrote:
> > 
> > * david singleton <dsingleton@mvista.com> wrote:
> > 
> > > Sure.  Attached is the locking fix patch. [...]
> > 
> > thanks, applied - it should show up in -rt15.
> > 
> 
> I just noticed with the above fix, Paul's testcase completely
> hangs up and when killed I hit the BUG mentioned below.
> Till -rt13, this testcase just ran to completion

Forgot to mention that I notice the same failure with -rt15 as well

	-Dinakar

