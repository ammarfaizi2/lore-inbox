Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVHLNR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVHLNR2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 09:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVHLNR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 09:17:28 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:45457 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751171AbVHLNR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 09:17:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: [-mm patch] Avoid divide by zero errors in sched.c
Date: Fri, 12 Aug 2005 23:17:04 +1000
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <1123852222.9234.7.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1123852222.9234.7.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508122317.04387.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005 23:10, Dave Kleikamp wrote:
> This patch fixes a divide-by-zero error that I hit on a two-way i386
> machine.  rq->nr_running is tested to be non-zero, but may change by the
> time it is used in the division.  Saving the value to a local variable
> ensures that the same value that is checked is used in the division.
>
> Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

Acked-by: Con Kolivas <kernel@kolivas.org>
