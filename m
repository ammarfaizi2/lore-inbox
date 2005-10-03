Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVJCPFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVJCPFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbVJCPFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:05:17 -0400
Received: from kanga.kvack.org ([66.96.29.28]:64997 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751002AbVJCPFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:05:16 -0400
Date: Mon, 3 Oct 2005 11:03:12 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: vikas gupta <vikas_gupta51013@yahoo.co.in>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Denis Vlasenko <vda@ilport.com.ua>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-xx-all.diff is not working for 2.6.13 arm kernel
Message-ID: <20051003150312.GC25653@kvack.org>
References: <20051003100731.GB16717@flint.arm.linux.org.uk> <20051003105511.90508.qmail@web8408.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003105511.90508.qmail@web8408.mail.in.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 11:55:11AM +0100, vikas gupta wrote:
> These functions are defined for i386 as well as x86_64
> 
> but for arm platform as above mentioned files (those i
> mentioned in previos mails )are not present these are
> giving errors ...
> So i wanted to ask whether any patch is available for
> it or not

Nobody has done the work to add the aio_up()/aio_down() primatives for 
arm yet, so you'll have to do that work for arm in order to use the 
patches.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
