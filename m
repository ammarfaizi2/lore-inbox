Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265790AbUFORjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265790AbUFORjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265787AbUFORjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:39:22 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:22160 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265790AbUFORjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:39:14 -0400
Message-ID: <40CF33D6.80302@colorfullife.com>
Date: Tue, 15 Jun 2004 19:37:26 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: pj@sgi.com, linux-kernel@vger.kernel.org,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>
Subject: Re: NUMA API observations
References: <40CE824D.9020300@colorfullife.com> <20040615110320.GD50463@colin2.muc.de>
In-Reply-To: <20040615110320.GD50463@colin2.muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Or maybe just a sysctl. But it doesn't really help because
>applications have to work with older kernels.
>
What's the largest number of cpus that are supported right now? 256?
First call sysctl or whatever. If it fails, then glibc can assume 256. 
If someone installs an old kernel on a new computer then it's his own 
fault. The API is broken, we should fix it now - it will only get more 
painful in the future.

--
    Manfred
