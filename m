Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbUD2AjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUD2AjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUD2AjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:39:13 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:25269 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262217AbUD2AjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:39:09 -0400
Message-ID: <40904EAA.6010501@yahoo.com.au>
Date: Thu, 29 Apr 2004 10:39:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: FabF <Fabian.Frederick@skynet.be>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.6-rc3] as-io isolation ?
References: <1083183861.4618.13.camel@bluerhyme.real3>
In-Reply-To: <1083183861.4618.13.camel@bluerhyme.real3>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF wrote:
> Hi,
> 
> 	Here's a patch _idea_ to isolate anticipatory I/O from normal I/O
> scheduler process by adding a specific put io context method so that
> ll_rw_blk stuff could be as-iosched transparent.I guess we could point
> as iosched exit instead of exit_io_context as well ...

Hi,
This makes ll_rw_blk.c aware of an AS specific function though.
as-iosched.c is actually a CONFIG option under CONFIG_EMBEDDED.
What is the actual problem?

Nick
