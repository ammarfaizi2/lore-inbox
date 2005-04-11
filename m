Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVDKSGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVDKSGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVDKSGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:06:20 -0400
Received: from mail.timesys.com ([65.117.135.102]:57558 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261867AbVDKSEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:04:15 -0400
Message-ID: <425ABC01.2020100@timesys.com>
Date: Mon, 11 Apr 2005 14:03:45 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dwalker@mvista.com
CC: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: RT and Signals
References: <1113239666.30549.37.camel@dhcp153.mvista.com>
In-Reply-To: <1113239666.30549.37.camel@dhcp153.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Apr 2005 17:59:53.0625 (UTC) FILETIME=[43741090:01C53EC0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> 	I'm not sure if this has changed at all in recent RT patches, but I've
> noticed several issues popping up that are related to the timer
> interrupt sending signals...

I've also seen BUG asserts kicking in on PPC (40-04-ish) in
signal delivery [actual receipt] paths.  These have only been
under fairly heavy load conditions and presumably is hitting
an infrequent path in force_sig_info() IIRC.  Haven't had the
time yet to resolve these but they are on the list.

-john


-- 
john.cooper@timesys.com
