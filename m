Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263723AbSIQOiz>; Tue, 17 Sep 2002 10:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbSIQOiz>; Tue, 17 Sep 2002 10:38:55 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:54474 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263723AbSIQOiy>; Tue, 17 Sep 2002 10:38:54 -0400
Date: Tue, 17 Sep 2002 16:39:34 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: torvalds@transmeta.com, hpa@transmeta.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cpufreq@www.linux.org.uk
Subject: [PATCH] Re: CPUfreq documentation (4/5)
Message-ID: <20020917163933.A853@brodo.de>
References: <20020917113547.H25385@brodo.de> <1032257979.3070.29.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
In-Reply-To: <1032257979.3070.29.camel@nomade>; from xavier.bestel@free.fr on Tue, Sep 17, 2002 at 12:19:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xavier,

Thanks for the two corrections!

On Tue, Sep 17, 2002 at 12:19:37PM +0200, Xavier Bestel wrote:
> Le mar 17/09/2002 à 11:35, Dominik Brodowski a écrit :
> 
> > +The third argument, a void *pointer, points to a struct cpufreq_freqs
> > +consisting of five values: cpu, min, max, policy and max_cpu_freq. Min 
> 
> - The struct cpufreq_freqs actually consists of only three values (cpu,
> old, new). The five values you cite here are in the struct
> cpufreq_policy.

	Dominik

--- linux/Documentation/cpufreq.original	Tue Sep 17 16:36:32 2002
+++ linux/Documentation/cpufreq	Tue Sep 17 16:37:09 2002
@@ -76,7 +76,6 @@
 ---------------------------------
     Note that you can only switch the speed of two logical CPUs at
     once - but each phyiscal CPU may have different throttling levels.
-    Unfortunately, the cpu_khz value 
 
 
 PowerNow! K6:
@@ -222,7 +221,7 @@
 
 The phase is specified in the second argument to the notifier.
 
-The third argument, a void *pointer, points to a struct cpufreq_freqs
+The third argument, a void *pointer, points to a struct cpufreq_policy
 consisting of five values: cpu, min, max, policy and max_cpu_freq. Min 
 and max are the lower and upper frequencies (in kHz) of the new
 policy, policy the new policy, cpu the number of the affected CPU or
