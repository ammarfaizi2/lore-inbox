Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSHVRzu>; Thu, 22 Aug 2002 13:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSHVRzt>; Thu, 22 Aug 2002 13:55:49 -0400
Received: from AMarseille-201-1-2-125.abo.wanadoo.fr ([193.253.217.125]:32880
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S315337AbSHVRzq>; Thu, 22 Aug 2002 13:55:46 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dominik Brodowski <devel@brodo.de>
Cc: Gabriel Paubert <paubert@iram.es>,
       Yoann Vandoorselaere <yoann@prelude-ids.org>,
       <cpufreq@lists.arm.linux.org.uk>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: fix 32bits integer overflow in loops_per_jiffy
 calculation
Date: Thu, 22 Aug 2002 22:00:16 +0200
Message-Id: <20020822200016.12303@192.168.4.1>
In-Reply-To: <20020822194655.C2016@brodo.de>
References: <20020822194655.C2016@brodo.de>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In this specific case, we were talking about PPC since the problem
>> occured when I implemented cpufreq support to switch the speed
>> of the latest powerbooks between 667 and 800Mhz
>
>And the patch from Yoann solves this? Then it might be easiest to use this
>for the time being, and switch to George Anzinger's sc_math.h once 
>high-res-timer is merged.

Provided Yoann patch doesn't break other machines, that's what I would
do, yes.

Ben.


