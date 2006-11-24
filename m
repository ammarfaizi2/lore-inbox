Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966031AbWKXTOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966031AbWKXTOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 14:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965934AbWKXTOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 14:14:09 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:1461 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S935014AbWKXTOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 14:14:07 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45674453.9040108@s5r6.in-berlin.de>
Date: Fri, 24 Nov 2006 20:13:23 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Yan Burman <burman.yan@gmail.com>
CC: linux-kernel@vger.kernel.org, trivial@kernel.org, wli@holomorphy.com,
       sparclinux@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6] sparc: replace kmalloc+memset with kzalloc
References: <4566DF0A.3050803@gmail.com> <45672D00.8060903@s5r6.in-berlin.de> <456741DD.6060103@gmail.com>
In-Reply-To: <456741DD.6060103@gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yan Burman wrote:
> Stefan Richter wrote:
>> ...in this ^, the old code and your update don't check for NULL return.
> 
> Both of this parts are done at early stages, so it is probably:
> a) Impossible to recover from failure
> b) If you run out of memory at this stage, you are probably in very big
> trouble anyway
> 
> I could modify it to check and panic if the check fails.
> Would that be better?

I hope the domain experts answer this. (I have no recommendation but
wanted to point out a potential, although unlikely, cause for trouble.)
-- 
Stefan Richter
-=====-=-==- =-== ==---
http://arcgraph.de/sr/
