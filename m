Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbTATPoI>; Mon, 20 Jan 2003 10:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTATPoH>; Mon, 20 Jan 2003 10:44:07 -0500
Received: from quark.didntduck.org ([216.43.55.190]:10255 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S266100AbTATPoG>; Mon, 20 Jan 2003 10:44:06 -0500
Message-ID: <3E2C1B5D.1060808@didntduck.org>
Date: Mon, 20 Jan 2003 10:53:01 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Andrey V. Ignatov" <andrey@emax.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Incorrect CPUs (Xeon 1.8 with HT) frequency ?
References: <62115845787.20030120183231@emax.ru>
In-Reply-To: <62115845787.20030120183231@emax.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey V. Ignatov wrote:
> I think that kernel detect my CPUs not correctly. I have box with dual
> Xeon CPU 1.80GHz and HT feature. Kernel successfully found all 4
> virtual CPUs but frequency of each CPUs is incorrect as I mean.
> My system build on Intel® E7500 chipset.
> I try kernels : 2.4.20 & 2.4.21-pre3...
> Output from /proc/cpuinfo (for each processor the same):
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 1.80GHz
> stepping        : 7
> cpu MHz         : 798.659

Are you sure the Jumpers (or BIOS) are configured for the right 
frequency?  Jumperless motherboards in particular have a habit of 
reverting to a "safe" frequency if a boot fails or if you power off 
during POST.

--
				Brian Gerst

