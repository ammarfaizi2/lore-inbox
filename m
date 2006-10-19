Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946401AbWJSThV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946401AbWJSThV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423254AbWJSThV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:37:21 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:15554 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1423247AbWJSThU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:37:20 -0400
Message-ID: <4537D337.3020706@gmail.com>
Date: Thu, 19 Oct 2006 21:34:15 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: =?UTF-8?B?U3VuZSBNw7hsZ2FhcmQ=?= <sune@molgaard.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: speedstep-centrino: ENODEV
References: <EB12A50964762B4D8111D55B764A8454C1A4AF@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C1A4AF@scsmsx413.amr.corp.intel.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
>>> Also, can both of you send the complete acpidump output from 
>> your system. You can find acpidump in latest version of 
>> pmtools package here: 
>> http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
>>
>> May be obtained over there:
>>
>> [...]
>>
>>>>>> processor, but speedstep-centrino returns ENODEV because of 
>>>>>> lack of _PCT et al 
>>>>>> entries in DSDT (http://www.fi.muni.cz/~xslaby/sklad/adump). 
>> ----------------------^^^^
>>
> 
> Looking at the acpidump, looks like BIOS doesn't have this feature enabled. Can you also make sure you have latest BIOS for the platform and also, check in BIOS whether there are any options to enable this feature.

Oh my god, I am a chump! Sorry; I had disabled this in BIOS. After enabling it,
acpidump contains _PCT et al and speedstep-centrino works.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

