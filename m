Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbSKSXLs>; Tue, 19 Nov 2002 18:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbSKSXLs>; Tue, 19 Nov 2002 18:11:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:35970 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267573AbSKSXLr>;
	Tue, 19 Nov 2002 18:11:47 -0500
Message-ID: <3DDAC6D4.F0F78941@digeo.com>
Date: Tue, 19 Nov 2002 15:18:44 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove magic numbers in block queue initialization
References: <1037747198.1252.2259.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Nov 2002 23:18:44.0759 (UTC) FILETIME=[0175F270:01C29022]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> Andrew,
> 
> Your less-requests patch signaled a way-too-many magic numbers alarm
> (not the patches fault, of course, but it pointed it out).
> 
> Attached patch removes the minimum queue length, maximum queue length,
> factor of queue length that is number of batch requests, and the maximum
> number of batch request magic numbers and replaces them with defines and
> some comments.
> 
> Look OK?
> 

Spose so.  Sometime soon these need to be per-queue rather than global,
and set to intelligent defaults by the driver and runtime tunable
via files in /whereveritsmounted.
