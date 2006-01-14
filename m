Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWANFlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWANFlX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 00:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWANFlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 00:41:23 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:56008 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751515AbWANFlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 00:41:22 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: -mm seems significanty slower than mainline on kernbench
Date: Sat, 14 Jan 2006 16:40:44 +1100
User-Agent: KMail/1.9
Cc: Peter Williams <pwil3058@bigpond.net.au>, Martin Bligh <mbligh@google.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <43C45BDC.1050402@google.com> <43C84496.6060506@bigpond.net.au> <43C8861E.5070203@yahoo.com.au>
In-Reply-To: <43C8861E.5070203@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141640.45582.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 16:03, Nick Piggin wrote:
> Ideally, balancing should be completely unaffected when all tasks are
> of priority 0 which is what I thought yours did, and why I think the
> current system is not great.

The current smp nice in mainline 2.6.15 is performance neutral when all are 
the same priority. It's only this improved version in -mm that is not.

Con
