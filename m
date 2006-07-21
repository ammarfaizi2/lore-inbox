Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWGUP3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWGUP3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 11:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWGUP3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 11:29:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:39487 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750795AbWGUP3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 11:29:02 -0400
X-IronPort-AV: i="4.07,169,1151910000"; 
   d="scan'208"; a="68686127:sNHT2673076329"
Message-ID: <44C0F13E.2030008@intel.com>
Date: Fri, 21 Jul 2006 08:22:38 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       Auke Kok <auke-jan.h.kok@intel.com>, pavel@ucw.cz, cramerj@intel.com,
       john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: e1000: "fix" it on thinkpad x60 / eeprom checksum read fails
References: <20060721005832.GA1889@elf.ucw.cz> <44BFADA6.6090909@intel.com> <20060720170758.GA9938@atrey.karlin.mff.cuni.cz> <44BFBE9F.7070600@intel.com> <20060721064105.aa960acd.akpm@osdl.org> <20060721151239.GC2290@thunk.org>
In-Reply-To: <20060721151239.GC2290@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jul 2006 15:23:40.0091 (UTC) FILETIME=[A4E3C8B0:01C6ACD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Fri, Jul 21, 2006 at 06:41:05AM -0700, Andrew Morton wrote:
>>> It's completely not acceptable to run when the EEPROM checksum fails - you 
>>> might even be running with the wrong MAC address, or worse. Lets fix this the 
>>> right way instead.
>> A printk which helps the user to understand all this saga would be very nice.
>> -
> 
> And if someone who understands all of these details could put a note
> in the thinkwiki (say, here:
> http://www.thinkwiki.org/wiki/Ethernet_Controllers#Intel_Gigabit_.2810.2F100.2F1000.29)
> it would be greatly appreciated.
> 

why don't I do that :)


Andrew: I'm contemplating that printk...


Cheers,

Auke
