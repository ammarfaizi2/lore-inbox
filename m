Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270596AbUKAQmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270596AbUKAQmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270603AbUKAQmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 11:42:12 -0500
Received: from av1-1-sn1.fre.skanova.net ([81.228.11.107]:18603 "EHLO
	av1-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S265244AbUKAQkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 11:40:43 -0500
Message-ID: <418666FF.6080404@lanil.mine.nu>
Date: Mon, 01 Nov 2004 17:40:31 +0100
From: Christian Axelsson <smiler@lanil.mine.nu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040927)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn Starr <shawn.starr@rogers.com>
Cc: ipw2100-devel@lists.sourceforge.net, Oliver Neukum <oliver@neukum.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Ipw2100-devel] Re: [2.6.10-rc1-mm2] Firmware loader gone bogus?
References: <200410311627.02116.shawn.starr@rogers.com> <200411010134.19922.oliver@neukum.org> <200410312050.48975.shawn.starr@rogers.com> <200410312134.46587.shawn.starr@rogers.com>
In-Reply-To: <200410312134.46587.shawn.starr@rogers.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, this fixes it

Shawn Starr wrote:
> See: http://marc.theaimsgroup.com/?l=linux-kernel&m=109919609211671&w=2
> 
> This will appear in the next -bk automated snapshot soon.
> 
> That should fix everyone's firmware load failures.
> 
> Shawn.
> 
> On October 31, 2004 20:50, Shawn Starr wrote:
> 
>>0.0.20040329-1 Linux Hotplug Scripts
>>
>>hotplug_20040329 from Debian unstable/testing.
>>
>>Using 2.6.9-rc4-xx I had no problems with loading the firmware. As in my
>>previous emails on the subject, I posted some debug that from the firmware
>>module and kobject_hotplug, and from there I couldn't see why it was
>>failing.
>>
>>I know lots of changes have been made to hotplug in the kernel recently.
>>
>>Shawn.
>>
>>On October 31, 2004 19:34, Oliver Neukum wrote:
>>
>>>Am Sonntag, 31. Oktober 2004 22:27 schrieb Shawn Starr:
>>>
>>>>Yeah I noticed my ipw2200 firmware broke in 2.6.10-rc1-bk5
>>>>
>>>>Does 2.6.10-rc1 non-bk snapshots work for you?
>>>
>>>Which script do you use to load the firmware?
>>>
>>> Regards
>>>  Oliver
>>
>>-------------------------------------------------------
>>This SF.Net email is sponsored by:
>>Sybase ASE Linux Express Edition - download now for FREE
>>LinuxWorld Reader's Choice Award Winner for best database on Linux.
>>http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
>>_______________________________________________
>>ipw2100-devel mailing list
>>ipw2100-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/ipw2100-devel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Regards,
Christian
