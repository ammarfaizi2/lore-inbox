Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUF0TRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUF0TRQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 15:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUF0TRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 15:17:16 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:16734 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S261763AbUF0TRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 15:17:12 -0400
Message-ID: <40DF1D22.2010406@travellingkiwi.com>
Date: Sun, 27 Jun 2004 20:16:50 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
References: <1088160505.3702.4.camel@tyrosine> <40DDBA7A.6010404@travellingkiwi.com> <40DF0A98.9040604@travellingkiwi.com> <200406272052.43326@zodiac.zodiac.dnsalias.org>
In-Reply-To: <200406272052.43326@zodiac.zodiac.dnsalias.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Gran wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Am Sonntag, 27. Juni 2004 19:57 schrieb Hamie:
>  
>
>>FWIW the sound & networking appear to run fine for a while after
>>resuming. But I just started a DVD. It ran fine for about 30 seconds and
>>then the sound went. About 30 seconds later the video froze and the app
>>(xine) has frozen also. (kill -9 time...).
>>    
>>
> <>
> I can confirm that here:
> after resuming, network completely works (yeah!).
> Sound doesn't.
> unloading/reloading the sound driver does not help.
> USB works jumpy (perhaps 5-10hz)
> Reloading does the trick for usb.
>

Since it sounds like a different bug to 2643, (Similiar but the patch 
that fixes the ethernet doesn't appear to doa  lot for the sound). I've 
opened a new one... #2965.

