Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752630AbWAHOZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbWAHOZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 09:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbWAHOZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 09:25:56 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:46787 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1752630AbWAHOZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 09:25:54 -0500
Message-ID: <43C12071.5010208@ens-lyon.org>
Date: Sun, 08 Jan 2006 09:23:45 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.15-mm2
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A1348A@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A1348A@hdsmsx401.amr.corp.intel.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:

> 
>  
>
>>2) acpi-cpufreq does not load either, returns ENODEV too. It's probably
>>git-acpi. I tried to revert it but there are lots of other patches
>>depending on it, so I finally gave up.
>>    
>>
>
>Brice,
>Can you try the converse?
>Apply the acpi patch (which is included in -mm)
>without the rest of the mm tree to see if that broke acpi-cpufreq?:
>
>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.15/acpi-test-20051216-2.6.15.diff.bz2
>
>thanks,
>-Len
>  
>

Len,

This patch applied on top of 2.6.15 breaks acpi-cpufreq in the same way.

Brice

