Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267660AbSLTAMr>; Thu, 19 Dec 2002 19:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267664AbSLTAMr>; Thu, 19 Dec 2002 19:12:47 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:19328 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267660AbSLTAMr> convert rfc822-to-8bit; Thu, 19 Dec 2002 19:12:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Robert Love <rml@tech9.net>, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
Date: Fri, 20 Dec 2002 11:22:59 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200212200850.32886.conman@kolivas.net> <3E025E1A.EA32918A@digeo.com> <1040343306.2519.85.camel@phantasy>
In-Reply-To: <1040343306.2519.85.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212201122.59691.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Thu, 2002-12-19 at 19:02, Andrew Morton wrote:
>> What Con said.  When the scheduler makes an inappropriate decision,
>> shortening the timeslice minimises its impact.
>
>OK, I tried it.  It does suck.
>
>I wonder why, though, because with the estimator off the scheduler
>should not be making "bad" decisions.

Is it just because the base timeslices are longer than the old scheduler?

Con
