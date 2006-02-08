Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161104AbWBHQtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbWBHQtY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWBHQtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:49:23 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:27350 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161104AbWBHQtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:49:23 -0500
Subject: Re: preempt-rt, NUMA and strange latency traces
From: john stultz <johnstul@us.ibm.com>
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139395534.21471.13.camel@frecb000686>
References: <1139311689.19708.36.camel@frecb000686>
	 <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
	 <1139395534.21471.13.camel@frecb000686>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Feb 2006 08:49:28 -0800
Message-Id: <1139417369.16302.1.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 11:45 +0100, Sébastien Dugué wrote:
>   The more I think about it, the more I tend to believe it's hardware 
> related. It seems as if the CPU just hangs for ~27 ms before
> resuming processing.

That sounds like to the ~30ms RSA caused SMIs. Does this system have an
RSA1 or RSA2 card?

thanks
-john


