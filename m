Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWC3OcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWC3OcY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWC3OcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:32:24 -0500
Received: from mail.customers.edis.at ([62.99.242.131]:6017 "EHLO
	smtp-1.edis.at") by vger.kernel.org with ESMTP id S932232AbWC3OcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:32:24 -0500
Message-ID: <442BEBED.8080205@lawatsch.at>
Date: Thu, 30 Mar 2006 16:32:13 +0200
From: Philip Lawatsch <philip@lawatsch.at>
Organization: WaUG HQ Graz
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8) Gecko/20060319 Thunderbird/1.5 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: JimD <Jim@keeliegirl.dyndns.org>, linux-kernel@vger.kernel.org
Subject: Re: AMD64 overclock issue with 2.6.16 but not with 2.6.15
References: <20060329143523.3bbb4df7@keelie.localdomain> <200603292054.09385.s0348365@sms.ed.ac.uk>
In-Reply-To: <200603292054.09385.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Wednesday 29 March 2006 20:35, JimD wrote:
>> Do any one know of any other issues with amd64 and the
>> 2.6.16 series?  I have run into a weird issue.
> [snip]
>> The bogomips are showing the same though the kernel is not reporting
>> the correct MHz.  If I reboot and check the BIOS, the correct MHz is
>> reported.  I have not run any CPU benchmarks to see if performance is
>> really going back down to 2000 MHz.
>>
>> Does anyone have a clue what could be causing this?
> 
> At a guess, it sounds like you're trying to use cpufreq on an overclocked CPU, 
> a definitely no-no. Check your config for this option, remove it if desired.

Why is this a nono? I've been using that for quite a while without
problems. It seems that even though I overclocked it the system is
stable at all voltage / frequency steps. (I only modified the reference
clock and not the core voltages)

Also, 2.16 only shows a wrong value, the cpu is clocked at the "correct"
(overclocked) frequency, at least the bogomips value matches what I'm
expecting.

kind regards Philip

