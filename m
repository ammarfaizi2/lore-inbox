Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUCFVAW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 16:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUCFVAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 16:00:22 -0500
Received: from opersys.com ([64.40.108.71]:37646 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261689AbUCFVAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 16:00:21 -0500
Message-ID: <404A3CFC.1050603@opersys.com>
Date: Sat, 06 Mar 2004 16:05:00 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: bluefoxicy@linux.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel-User shared buffer
References: <20040306000616.1D51F3953@sitemail.everyone.net>
In-Reply-To: <20040306000616.1D51F3953@sitemail.everyone.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


john moser wrote:
> I'm trying to create a shared buffer for realtime communication
> between the kernel and a userspace application.  All allocation
> is done for the userspace task in the kernel, and the kernel is
> to write to the ram from within syscalls made by other
> processes.

I'm not sure what you mean by "realtime", but have a look at relayfs:
http://www.opersys.com/relayfs/index.html

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

