Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUHFPcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUHFPcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268139AbUHFPcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:32:02 -0400
Received: from holomorphy.com ([207.189.100.168]:461 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268148AbUHFPZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:25:53 -0400
Date: Fri, 6 Aug 2004 08:25:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
Message-ID: <20040806152549.GJ17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org> <20040805130308.GC14358@holomorphy.com> <20040805143848.1985deb2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805143848.1985deb2.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> +#include <linux/config.h>
>> +#include <linux/device.h>
>>  #include <asm/machvec.h>

On Thu, Aug 05, 2004 at 02:38:48PM -0700, Andrew Morton wrote:
> Yes, I hit the same problem on x86_64.  But I have no patches touching
> that file.  Can you send the compiler output, help me work out which patch
> needs the patch?

Bizarre thing happened: I backed out the change and couldn't reproduce
it. Not sure what's going on.


-- wli
