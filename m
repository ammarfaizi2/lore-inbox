Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUE2BDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUE2BDc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 21:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUE2BDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 21:03:32 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:28979 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262101AbUE2BDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 21:03:30 -0400
Message-ID: <40B7E160.60609@blueyonder.co.uk>
Date: Sat, 29 May 2004 02:03:28 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1-mm1 lockup
References: <40B7CD1D.1070606@blueyonder.co.uk> <20040528165119.01a96be8.akpm@osdl.org>
In-Reply-To: <20040528165119.01a96be8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2004 01:03:32.0514 (UTC) FILETIME=[C2EE3820:01C44518]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>  
>
>>A7N8X-E motherboard, IDE HD's hda and hdc. Hangs forever as shown below. 
>>SYSRQ does nothing, needs a hard reset. 2.6.5-mm5 boots OK as does 
>>vanilla 2.6.7-rc1 which was built after 3 reboots of 2.6.7-rc1-mm1 hung.
>>    
>>
>
>Could you try adding `nmi_watchdog=1' to the boot command line?  Make sure
>that CONFIG_X86_LOCAL_APIC is enabled in kernel config.
>
>
>
>  
>
The first time booting with "nmi_watchdog=1" it halted with "Mounting 
/dev/pts" (seen the very first boot), then booting with "nmi_watchdog=1 
console=ttyS1", the capture was as before. Currently running 2.6.7-rc1 
vanilla.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

