Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUFFXrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUFFXrq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 19:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbUFFXrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 19:47:46 -0400
Received: from mail005.syd.optusnet.com.au ([211.29.132.54]:20456 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264228AbUFFXrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 19:47:45 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Date: Mon, 7 Jun 2004 09:47:31 +1000
User-Agent: KMail/1.6.1
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
References: <200406070139.38433.kernel@kolivas.org>
In-Reply-To: <200406070139.38433.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406070947.31104.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004 01:39, Con Kolivas wrote:
> This is an update of the scheduler policy mechanism rewrite using the
> infrastructure of the current O(1) scheduler. Slight changes from the
> original design require a detailed description. 

Seems it wasn't clear unless you look at the code; this has only a single 
priority queue with no expired array.

Con
