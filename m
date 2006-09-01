Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWIADIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWIADIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 23:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWIADIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 23:08:15 -0400
Received: from flpvm09.prodigy.net ([207.115.20.39]:8407 "EHLO
	flpvm09.prodigy.net") by vger.kernel.org with ESMTP
	id S1750868AbWIADIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 23:08:15 -0400
X-ORBL: [68.95.116.149]
Message-ID: <44F7A404.1070502@ksu.edu>
Date: Thu, 31 Aug 2006 22:07:48 -0500
From: "Scott J. Harmon" <harmon@ksu.edu>
User-Agent: Thunderbird 1.5.0.5 (X11/20060727)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Chris Wedgwood <cw@f00f.org>, vsu@altlinux.ru,
       linux-kernel@vger.kernel.org
Subject: Re: acpi gets wrong interrupt for via sata in 2.6.16.17
References: <449DE6BA.2050206@ksu.edu>	<20060625132457.4b0922b4.vsu@altlinux.ru>	<44A1C78C.4090401@ksu.edu>	<44ADAB1F.6040208@ksu.edu>	<20060706181453.3ce5a1c5.akpm@osdl.org>	<20060707034735.GA12908@tuatara.stupidest.org> <20060706205509.4e4ae2ee.akpm@osdl.org>
In-Reply-To: <20060706205509.4e4ae2ee.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is _still_ a problem with 2.6.17.11

Thanks,

Scott.

Andrew Morton wrote:
> On Thu, 6 Jul 2006 20:47:35 -0700
> Chris Wedgwood <cw@f00f.org> wrote:
> 
>> On Thu, Jul 06, 2006 at 06:14:53PM -0700, Andrew Morton wrote:
>>
>>> I have both reversion patches queued up but haven't heard from
>>> anyone about anything.
>> i saw that --- i don't think it's right, but it's not more wrong than
>> having that merged as-is in the first place which i'll argue is wrong
>> by virtue of the fact we run the quirk everywhere and apparently break
>> things
>>
>>> I don't know if anyone's working on this bug.
>> it's not forgotten, i'm waiting to hear back from people still.
>> enabling ACPI *should* suffice, but for some people clearly it doesn't
>> (there are claims VIA got their ACPI wrong so this might explain why
>> it works for some people and not others)
>>
>>> Thursday is my subsystem-maintainer-spamming day, so the reverts
>>> will be heading Gregwards today.
>> like i said, i really don't think reverting the patches is technically
>> correct, but given that i don't have adequate hardware to test against
>> it might be the least painful option right now
> 
> Yes, it's a question of whose machines we choose to break.
> 
> It'd be great to get this thing nailed.  Do the people who are out testing
> things need re-asking?  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
"Computer Science is no more about computers than astronomy is about
telescopes." - Edsger Dijkstra
