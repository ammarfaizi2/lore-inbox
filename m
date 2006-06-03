Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWFCSpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWFCSpS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 14:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWFCSpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 14:45:18 -0400
Received: from ns1.suse.de ([195.135.220.2]:28584 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751768AbWFCSpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 14:45:16 -0400
From: Chris Mason <mason@suse.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [patch] fix smt nice lock contention and optimization
Date: Sat, 3 Jun 2006 14:45:06 -0400
User-Agent: KMail/1.9.3
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Con Kolivas'" <kernel@kolivas.org>, "Ingo Molnar" <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <000701c686e1$71f2f7f0$df34030a@amr.corp.intel.com>
In-Reply-To: <000701c686e1$71f2f7f0$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606031445.08165.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 03:43, Chen, Kenneth W wrote:
> OK, final rolled up patch with everyone's changes. I fixed one bug
> introduced by Con's earlier patch that there is an unpaired
> spin_trylock/spin_unlock in the for loop of dependent_sleeper().
> Chris, Con, Nick - please review and provide your signed-off-by line.
> Andrew - please consider for -mm inclusion.  Thanks.

Thanks for turning my half baked code into something nice.  acked-by from me 
as well.

-chris
