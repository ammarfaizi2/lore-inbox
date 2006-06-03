Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWFCA1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWFCA1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 20:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWFCA1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 20:27:53 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:31935 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932589AbWFCA1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 20:27:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Sat, 3 Jun 2006 10:27:30 +1000
User-Agent: KMail/1.9.3
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
References: <000601c686a1$de148060$df34030a@amr.corp.intel.com>
In-Reply-To: <000601c686a1$de148060$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606031027.30538.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 10:08, Chen, Kenneth W wrote:
> I know what smt nice is doing, and it is fine to have.  I'm simply
> proposing the following patch, on top of last roll up patch.

It's still relative breakage of the semantics but I'm willing to concede that 
it will only help a very small proportion of the time with the largest 
timeslices and is in the fastpath.

-- 
-ck
