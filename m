Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbVGHR6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVGHR6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 13:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbVGHR6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 13:58:32 -0400
Received: from kanga.kvack.org ([66.96.29.28]:48034 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262737AbVGHR5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 13:57:24 -0400
Date: Fri, 8 Jul 2005 13:58:40 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: aio-stress throughput regressions from 2.6.11 to 2.6.12
Message-ID: <20050708175840.GD781@kvack.org>
References: <20050701075600.GC4625@in.ibm.com> <20050701142555.GB31989@kvack.org> <20050706043056.GA4223@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706043056.GA4223@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 10:00:56AM +0530, Suparna Bhattacharya wrote:
> Do you see the regression as well, or is it just me ?

Throughput for me on an ICH6 SATA system using O_DIRECT seems to remain 
pretty constant across 2.6.11-something-FC3 to 2.6.13-rc2 around 31MB/s.  
2.6.11 proper hangs for me, though.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
