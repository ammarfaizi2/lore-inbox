Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265291AbUGHCfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUGHCfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 22:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUGHCfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 22:35:15 -0400
Received: from holomorphy.com ([207.189.100.168]:4578 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265291AbUGHCfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 22:35:10 -0400
Date: Wed, 7 Jul 2004 19:30:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
Message-ID: <20040708023001.GN21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ECADF8.7010207@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
>> I created a test program that allocates a 300MB buffer and writes to
>> all bytes sequentially. On my computer, which has 256MB RAM and 512MB
>> swap, the program gets OOM killed after dirtying about 140-180MB, and
>> the kernel reports:

On Thu, Jul 08, 2004 at 12:14:16PM +1000, Nick Piggin wrote:
> Someone hand me a paper bag... Peter, can you give this patch a try?

Heh, one goes in while I'm not looking, and look what happens.


-- wli
