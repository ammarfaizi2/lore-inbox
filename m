Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265266AbUFHSCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbUFHSCB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 14:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbUFHSCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 14:02:01 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:38577 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S265266AbUFHSB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 14:01:57 -0400
Message-ID: <40C5FF1B.1050805@blue-labs.org>
Date: Tue, 08 Jun 2004 14:02:03 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.7-rc2
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org> <1086187044.6179.8.camel@hostmaster.org> <200406041706.27716.vda@port.imtp.ilyichevsk.odessa.ua> <ca4r6t$p16$1@gatekeeper.tmr.com>
In-Reply-To: <ca4r6t$p16$1@gatekeeper.tmr.com>
Content-Type: multipart/mixed;
 boundary="------------070201040102070509060404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070201040102070509060404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It would also help if there was a preliminary auto-detect option/feature 
in the main window that could get a quick idea of what can/should be 
enabled.

David

Bill Davidsen wrote:

> Denis Vlasenko wrote:
>
>> On Wednesday 02 June 2004 17:37, Thomas Zehetbauer wrote:
>>
>>> http://bugzilla.kernel.org/show_bug.cgi?id=2819
>>>
>>> Make oldconfig silently disabled support for my CONFIG_TIGON3 NIC.
>>>
>>> It seems that it depends on CONFIG_NET_GIGE which in turn depends on
>>> CONFIG_NET_ETHERNET which was not required in 2.6.6 kernel.
>>>
>>> Tom
>>
>>
>>
>> Many days ago I read on lkml that separating 10,100 and 1000 Mbit
>> ethernet is not really justified. There are devices which have
>> 100 and 1000 variants.
>>
>> Just keeping all ethernet devices in one menu sounds sane to me.
>
>
> There are other issues with the build process, when a driver supports 
> a chipset used in several products there's no reasonable way to find 
> out which driver should be used, and as you say the split of speed 
> makes less and less sense, and will just get worse when 10Ge is more 
> common.
>
> The solution may be an external table, program, or whatever, since the 
> situation changes as drivers are modified to support new models, 
> chipsets move to new vendors, etc. But it would be *really nice* to 
> find the 3c940 with 3COM drivers, instead of grepping driver source 
> and looking at spec sheets to find out that the driver is called 
> something like sk98lin, it's in an unobvious place and has a name 
> unrelated to 3COM.
>
> Here's a suggestion if someone wants to do something about this, like 
> LDP. Produce a CSV list of vendor name, like 3c940, name used for 
> config in the menu, module name and symbol in the .config file. Would 
> let users find things a lot faster, and could be used with grep as 
> well as some spreadsheet tool.
>

--------------070201040102070509060404
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------070201040102070509060404--
