Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423262AbWJSKLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423262AbWJSKLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423264AbWJSKLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:11:14 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:18170 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1423262AbWJSKLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:11:14 -0400
Subject: Re: [PATCH] s390: Point sys_getcpu_wrapper at the proper syscall.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061019093549.GA28354@linux-sh.org>
References: <20061019093549.GA28354@linux-sh.org>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 19 Oct 2006 12:11:12 +0200
Message-Id: <1161252672.4399.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 18:35 +0900, Paul Mundt wrote:
> Looking at the new syscall additions, I noticed that
> sys_getcpu_wrapper wraps in to sys_tee, in what appears to be
> a copy and paste error.  Switch it to point to sys_getcpu..
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>

Indeed, good spotting. Thanks the for patch.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


