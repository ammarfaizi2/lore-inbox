Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTD3Ip0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 04:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTD3Ip0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 04:45:26 -0400
Received: from k101-11.bas1.dbn.dublin.eircom.net ([159.134.101.11]:21267 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id S261449AbTD3IpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 04:45:25 -0400
Message-ID: <3EAF8E94.3090506@draigBrady.com>
Date: Wed, 30 Apr 2003 09:51:32 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
References: <200304300446.24330.dphillips@sistina.com> <20030430071907.GA30999@alpha.home.local> <20030430083607.GA6035@vitelus.com> <20030430085212.GC6035@vitelus.com>
In-Reply-To: <20030430085212.GC6035@vitelus.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> On Wed, Apr 30, 2003 at 01:36:07AM -0700, Aaron Lehmann wrote:
> 
>>>===== gcc-2.95.3 -march=i686 -O2 / athlon MP/2200 (1.8 GHz) =====
>>
>>-march=athlon would give gcc a chance to make better scheduling
>>decisions, which could make the results more sensible.
> 
> And contrary to my memory, gcc 2.95.3 doesn't seem to support
> march=athlon. I guess I need to go to sleep.

to bypass your memory:
http://www.pixelbeat.org/scripts/gcccpuopt

Pádraig.

