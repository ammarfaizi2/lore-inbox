Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbVHKAEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVHKAEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 20:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVHKAEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 20:04:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:45531 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964860AbVHKAEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 20:04:34 -0400
Date: Thu, 11 Aug 2005 02:04:33 +0200
From: Andi Kleen <ak@suse.de>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Mike Waychison <mikew@google.com>,
       YhLu <YhLu@tyan.com>, Peter Buckingham <peter@pantasys.com>,
       linux-kernel@vger.kernel.org, "discuss@x86-64.org" <discuss@x86-64.org>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
Message-ID: <20050811000430.GD8974@wotan.suse.de>
References: <3174569B9743D511922F00A0C94314230AF97867@TYANWEB> <42FA8A4B.4090408@google.com> <20050810232614.GC27628@wotan.suse.de> <86802c4405081016421db9baa5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c4405081016421db9baa5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So my patch still can be used with Eric's, It just serialize the
> TSC_SYNC between cpu.
> 
> I wonder it you can refine to make TSC_SYNC serialize that beteen CPU.
> That will make
> CPU X:synchronized TSC ... 
> in fixed postion and timming.

Why would we want that? 

Boot time is critical so it's better to do things asynchronous.

-Andi
