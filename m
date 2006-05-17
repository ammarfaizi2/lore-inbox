Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWEQDWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWEQDWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 23:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWEQDWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 23:22:46 -0400
Received: from mail.tmr.com ([64.65.253.246]:43155 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751191AbWEQDWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 23:22:45 -0400
Message-ID: <446A9AD0.6030509@tmr.com>
Date: Tue, 16 May 2006 23:38:56 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: marekw1977@yahoo.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: acpi4asus
References: <20060511130743.GG15876@mail.muni.cz> <20060511073211.1da40329.akpm@osdl.org> <200605121116.11930.marekw1977@yahoo.com.au> <44649A2E.4070803@tmr.com> <20060508234723.GB4349@ucw.cz>
In-Reply-To: <20060508234723.GB4349@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>>I am far from qualified to comment on this, but from a 
>>>users point of view, is it possible to not have laptop 
>>>specific code in the kernel?
>>>I have had two Linux laptops and with both I had ACPI 
>>>issues.
>>>The vendors of both laptops (Toshiba Tecra S1 and now 
>>>an Asus W3V) don't seem to be following standards. With 
>>>both I seem to need to patch ACPI to get various 
>>>functions of the laptop to work.
>>>I would love to see laptop specific functionality 
>>>definitions exist outside the kernel.
>>>
>>>      
>>>
>>I don't think that forcing laptop users to have their 
>>own code outside the kernel is really the best approach 
>>for either the developers or the users. Most users will 
>>    
>>
>
>No, we don't want that. But we do not want ibm-acpi, toshiba-acpi,
>asus-acpi, etc, when they really only differ in string constants used.
>
>We want userland to tell kernel 'mail led is controlled by AML routine
>foo', instead of having gazillion *-acpi modules.
>
>
>  
>
I see no reason why an interface to that couldn't be included in the 
kernel, with just a small table for each hardware instead of a whole 
module. Kind of a white list with detail.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

