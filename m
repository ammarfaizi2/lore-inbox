Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWFGRip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWFGRip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWFGRip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:38:45 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:60178 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932276AbWFGRio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:38:44 -0400
Message-ID: <44870F13.4030509@shadowen.org>
Date: Wed, 07 Jun 2006 18:38:27 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Martin Bligh <mbligh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
References: <4484D174.7080902@google.com> <20060606164241.69d55238.akpm@osdl.org>
In-Reply-To: <20060606164241.69d55238.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 05 Jun 2006 17:51:00 -0700
> Martin Bligh <mbligh@google.com> wrote:
> 
> 
>>http://test.kernel.org/abat/34264/debug/console.log
> 
> 
> What sort of machine is this, anyway?
> 
> 
>>WARNING: Not an IBM x440/NUMAQ and CONFIG_NUMA enabled!

Its confusing that that message is there, cause the machine in question
is an x440.  Then again I thought we'd only needed that cause of the
unaligned zones issue which if not nailed down we have fixes for.

Sadly this machine has just bitten the dust and I am waiting for a mendy
person to mend it.

-apw
