Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWKBRxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWKBRxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWKBRxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:53:41 -0500
Received: from mail.tmr.com ([64.65.253.246]:2200 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1750991AbWKBRxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:53:40 -0500
Message-ID: <454A306C.3050200@tmr.com>
Date: Thu, 02 Nov 2006 12:52:44 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: davidz@redhat.com, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH v2] Re: Battery class driver.
References: <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com> <znLIYxER.1162453921.3011900.khali@localhost>
In-Reply-To: <znLIYxER.1162453921.3011900.khali@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> On 10/31/2006, man with no name wrote:
>> In the case at hand we have mWh and mAh, which measure different
>> physical quantities. You can't convert between them unless you have
>> intimate knowledge of the battery's chemistry and condition, which we
>> don't.
> 
> You just need to know the voltage of the battery, what else?
> 
>> And it would be nice to also allow for power supply devices that use
>> other, incompatible units like "percent" or "minutes" or "hand crank
>> revolutions".
> 
> Do such batteries exist at the moment, or are you just speculating?

I have seen joules (or mJ) on a laptop. Yes, it was Windows, but I bet 
the report came from hardware. Some vendor getting anal about metric?
 > I
> don't quite see how a battery could report remaining energy in time
> units, as power consumption varies over time. Hand crank revolutions
> wouldn't be a very useful unit either, unless you know how much energy
> a revolution provides, and then you can just convert it. Percent would
> make some sense, but you can only express the remaining energy this way,
> not the total. And if you know the total in mAh or mWh, you can multiply
> by the percentage and you get the remaining energy in the same unit.
> 
> --
> Jean Delvare


-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
