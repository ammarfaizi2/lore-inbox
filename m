Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288498AbSAXP4m>; Thu, 24 Jan 2002 10:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSAXP4c>; Thu, 24 Jan 2002 10:56:32 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:20868
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S288498AbSAXP4X>; Thu, 24 Jan 2002 10:56:23 -0500
Date: Thu, 24 Jan 2002 08:55:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>
Cc: Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] preemptive kernel
Message-ID: <20020124155557.GM1816@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020124153123Z288377-13996+11264@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020124153123Z288377-13996+11264@vger.kernel.org>
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 04:31:07PM +0100, Dieter N?tzel wrote:

> Hello Robert,
> 
> can you please redo for O(1)-J6 (2.4.18-pre7) or is nothing changed?

Or -J6 there was a small reject, it looks like -J6 sets p->cpu =
smp_processor_id(); in kernel/sched.c, which the preempt patch wants to
do as well.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
