Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270753AbTHFRbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270869AbTHFR3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:29:07 -0400
Received: from holomorphy.com ([66.224.33.161]:23181 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270819AbTHFR2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:28:43 -0400
Date: Wed, 6 Aug 2003 10:29:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops 2.6.0-test2-mm4 in pmd_dtor
Message-ID: <20030806172956.GW32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0308060644280.7244@montezuma.mastecende.com> <Pine.LNX.4.53.0308060759510.7244@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308060759510.7244@montezuma.mastecende.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003, Zwane Mwaikambo wrote:
>> Hey Bill i thought you had a fix for this? Box has 16G of RAM.

On Wed, Aug 06, 2003 at 08:01:43AM -0400, Zwane Mwaikambo wrote:
> Hmm ok i found your email about PTRS_PER_PMD and PAE.
> Thanks,
> 	Zwane

This is the pgd_dtor() list poison oops (the memory.c not blitting the
whole kernel pmd issue should look like a deadlock). They're both taken
care of in some patch that only existed in /tmp/ files outside email
I'll have to reconstitute for you.


-- wli
