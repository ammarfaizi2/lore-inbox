Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264004AbSIQKOo>; Tue, 17 Sep 2002 06:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264025AbSIQKOo>; Tue, 17 Sep 2002 06:14:44 -0400
Received: from AMontpellier-205-1-13-198.abo.wanadoo.fr ([80.14.68.198]:26375
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S264004AbSIQKOo> convert rfc822-to-8bit; Tue, 17 Sep 2002 06:14:44 -0400
Subject: Re: [PATCH][2.5.35] CPUfreq documentation (4/5)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, hpa@transmeta.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cpufreq@www.linux.org.uk
In-Reply-To: <20020917113547.H25385@brodo.de>
References: <20020917113547.H25385@brodo.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 12:19:37 +0200
Message-Id: <1032257979.3070.29.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 17/09/2002 à 11:35, Dominik Brodowski a écrit :

> +The third argument, a void *pointer, points to a struct cpufreq_freqs
> +consisting of five values: cpu, min, max, policy and max_cpu_freq. Min 
> +and max are the lower and upper frequencies (in kHz) of the new
> +policy, policy the new policy, cpu the number of the affected CPU or
> +CPUFREQ_ALL_CPUS for all CPUs; and max_cpu_freq the maximum supported
> +CPU frequency. This value is given for informational purposes only.

- Why choosing a void* ? that doesn't validate type ..

- The struct cpufreq_freqs actually consists of only three values (cpu,
old, new). The five values you cite here are in the struct
cpufreq_policy.


