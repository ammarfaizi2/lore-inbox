Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268290AbTGLS2U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268294AbTGLS2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:28:19 -0400
Received: from dm4-153.slc.aros.net ([66.219.220.153]:47046 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S268290AbTGLS2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:28:18 -0400
Message-ID: <3F1056B4.30208@aros.net>
Date: Sat, 12 Jul 2003 12:43:00 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Udo Hoerhold <maillists@goodontoast.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hard lockups with 2.5.75
References: <200307121425.29939.maillists@goodontoast.com>
In-Reply-To: <200307121425.29939.maillists@goodontoast.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Udo Hoerhold wrote:

>I switched from 2.5.73 to 2.5.75 yesterday, and I've encountered three hard 
>lockups in the 24 hours I've been running the new kernel.  When I reset the 
>machine, I don't see anything unusual in the logs.
>
>The machine is a dual PIII with aic7899 SCSI and 3c905c network on the 
>motherboard.  In all three cases where I locked up, there was network and 
>disk IO going on.  I don't really have any more info.
>
>If anyone would like to give me a list of things to try, I'd be happy to do 
>some testing.
>
Do you already have all the kernel hacking options turned on? 
Particularly the CONFIG_DEBUG_* options? If not, rebuilding and getting 
the same lockup may provide some additional info. You may also want to 
try with the PREEMPT option turned on (if not aleady).

