Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSGUQIR>; Sun, 21 Jul 2002 12:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSGUQIR>; Sun, 21 Jul 2002 12:08:17 -0400
Received: from pD9E09781.dip.t-dialin.net ([217.224.151.129]:58825 "EHLO
	marvin.milliways.de") by vger.kernel.org with ESMTP
	id <S316580AbSGUQIQ>; Sun, 21 Jul 2002 12:08:16 -0400
Message-ID: <3D3ADC3E.9050307@milliways.de>
Date: Sun, 21 Jul 2002 18:07:26 +0200
From: Markus Pfeiffer <profmakx@profmakx.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CPU detection broken in 2.5.27?
References: <200207211537.03813.mcp@linux-systeme.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just noticed that my /proc/cpuinfo states wrong or incomplete 
information about my processor. My PIII-1000M Processor is reported as 
00/0B (Stepping?) and with only 32 KB of cache (which obviously is the 
L1d and L1i value). I think this happened during the split of the CPU 
detection code... I found nothing about that in archives or similar 
(i.e. on the list).
Perhaps someone who knows how to do it can look into that as i would 
need hours just to understand just what they are doing there and to read 
the specs of the CPUID instruction etc

Thanks in advance

Markus


