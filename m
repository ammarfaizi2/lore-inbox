Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264040AbSIQKix>; Tue, 17 Sep 2002 06:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264042AbSIQKix>; Tue, 17 Sep 2002 06:38:53 -0400
Received: from k100-28.bas1.dbn.dublin.eircom.net ([159.134.100.28]:1298 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S264040AbSIQKix>;
	Tue, 17 Sep 2002 06:38:53 -0400
Message-ID: <3D870734.9080301@corvil.com>
Date: Tue, 17 Sep 2002 11:43:00 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@brodo.de>
CC: torvalds@transmeta.com, hpa@transmeta.com, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH][2.5.35] CPU frequency and voltage scaling (0/5)
References: <20020917113047.C25385@brodo.de>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> Hi Linus, hpa, lkml,
> 
> The following patches add CPU frequency and volatage scaling
> support (Intel SpeedStep, AMD PowerNow, etc.) to kernel 2.5.35.
> 
> As was discussed last time, the cpufreq patches have been reworked to use a
> policy-based approach now. A cpufreq policy consists of four values:
> cpu	-	the affected CPU nr., or CPUFREQ_ALL_CPUS for all cpus
> min	-	minimum frequency in kHz
> max	-	maximum frequency in kHz
> policy	-	CPUFREQ_POLICY_PERFORMANCE or CPUFREQ_POLICY_POWERSAVE
> 

This is much better, but I preferred Dave Jones' suggestion of
supporting stackable policies as I can see no end to them:
max_cpu_temp, temp_hysteresis, favor_fast_{fsb,multiplier}, ...

Pádraig.

