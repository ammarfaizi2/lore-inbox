Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbVKRSME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbVKRSME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbVKRSME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:12:04 -0500
Received: from dsl093-119-032.blt1.dsl.speakeasy.net ([66.93.119.32]:57218
	"EHLO bushido.realityfailure.org") by vger.kernel.org with ESMTP
	id S1161039AbVKRSMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:12:03 -0500
Date: Fri, 18 Nov 2005 13:11:52 -0500 (EST)
From: John Jasen <jjasen@realityfailure.org>
X-X-Sender: jjasen@bushido
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Bharath Ramesh <krosswindz@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: intel8x0 sound of silence on dell system
In-Reply-To: <20051118180410.GA22566@kvack.org>
Message-ID: <Pine.LNX.4.63.0511181310410.23989@bushido>
References: <20051118162300.GA22092@kvack.org>
 <c775eb9b0511180959r12206562h5a294d9505d95d04@mail.gmail.com>
 <20051118180410.GA22566@kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (bushido.realityfailure.org [10.0.0.10]); Fri, 18 Nov 2005 13:11:53 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005, Benjamin LaHaise wrote:

> No, like I said, booting the RHEL4 kernel works like a charm.  alsamixer
> does not show it being muted.

Sometimes, mine would get in the same state, but on a laptop.

You can try adding buggy_irq=1, buggy_semaphore=1 or both to your 
modprobe.conf file, and see if any of those help. It did in my case.

-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- No one will sorrow for me when I die, because those who would
-- are dead already. -- Lan Mandragoran, The Wheel of Time, New Spring
