Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbVKHPUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVKHPUE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 10:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbVKHPUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 10:20:04 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:41081 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030202AbVKHPUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 10:20:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ORlzFVr9BG6jkp6Ddl4S2vGiY1kmYip7P64wCOSRGd7yyUbukzYFbG8ccsAT3XPTYq44GSAD16g0NAPjGrjuma3knS8vBbOG/vfvevAzSlYIO70YOnZeyzpwuo6HGas081U42fa7fCxC4oG6ZSXTSolRzijgSE61Ss3DHa5OjJE=
Message-ID: <4370C21C.6040402@gmail.com>
Date: Tue, 08 Nov 2005 16:19:56 +0100
From: Patrizio <patrizio.bassi@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Shaohua Li <shaohua.li@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-git4 suspend fails: kernel NULL pointer dereference
References: <20051006072749.GA2393@spitz.ucw.cz> <20051107164715.GA1534@elf.ucw.cz> <1131411772.3003.1.camel@linux-hp.sh.intel.com> <20051108091254.GE15730@elf.ucw.cz>
In-Reply-To: <20051108091254.GE15730@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek ha scritto:

>Hi!
>
>  
>
>>>>echo shutdown > /sys/power/disk
>>>>echo disk > /sys/power/state
>>>>
>>>>Unable to handle kernel NULL pointer dereference at virtual address 00000004
>>>> printing eip:
>>>>EIP:    0060:[<c0132a5e>]    Not tainted VLI
>>>>EFLAGS: 00010286   (2.6.14-git4)
>>>>EIP is at enter_state+0xe/0x90
>>>>        
>>>>
>>>It works for me, with pretty recent tree. But I see a potential
>>>problem there, you are not using ACPI, right?
>>>      
>>>
>
>  
>
>>It's my bad. Thanks for fixing this, Pavel. Maybe patrizio didn't enable
>>ACPI sleep.
>>    
>>
>
>Will you take care of pushing that patch to mainline?
>								Pavel
>  
>
i'm so sorry, had a hd problem, i've only got the compiled vmlinux

:(((

infact i seached to apply to vanilla kernel.

however Len Brown told me he would have applied such patch for 2.6.15

please contact him

Patrizio
