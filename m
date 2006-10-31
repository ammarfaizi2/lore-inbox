Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423545AbWJaQL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423545AbWJaQL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423541AbWJaQL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:11:26 -0500
Received: from mail.tmr.com ([64.65.253.246]:20357 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1423545AbWJaQLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:11:25 -0500
Message-ID: <454775C6.5030604@tmr.com>
Date: Tue, 31 Oct 2006 11:11:50 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lspci output needed was Re: Frustrated with Linux, Asus, and
 nVidia, and AMD
References: <fa.nWSYbiDM13Z4b2OlxoSzmqud/lI@ifi.uio.no> <fa.i/oIAoig46I/apLGccQ0BesB0W8@ifi.uio.no> <454432DC.9030006@shaw.ca> <200610311528.20013.ak@suse.de>
In-Reply-To: <200610311528.20013.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>There are clearly some NVIDIA chipsets which require the override be 
>>skipped, and some which require it not be. I think the ball is currently 
>>in NVIDIA's court to provide a way of figuring out which chipsets 
>>require the quirk and which don't..
>>    
>>
>
>My current plan is to switch in 2.6.20 to automatic probing of more pins
>for the timer routing (suggested by Tim Hockin, I've got a test patch). 
>  
>
Thank you, Tim!

>But that's too risky for .19.
>
>For 2.6.19 we'll likely add some more PCI-IDs disabling the quirk
>and a command line option to disable the skip timer override quirk. 
>  
>
That should be safe, and timer override as an option should give 
everyone a way to get what they need on any given system.

>Doing this per PCI ID isn't that bad because afaik Vista certification
>requires enabling the HPET table and I assume most boards will get
>Vista certification soon. This will force Asus to fix their BIOS.
>  
>
And nVidia to release more information? Hopefully.

>Can people who use a Nvidia based AM2/SocketF board (especially when they have timer 
>troubles but otherwise would be useful too) please report their lspcis in private 
>mail to me?
>
>-Andi
>
>
>  
>


-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

