Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVAKTAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVAKTAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVAKTAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:00:13 -0500
Received: from gw.unix-scripts.info ([62.212.121.13]:29418 "EHLO
	gw.unix-scripts.info") by vger.kernel.org with ESMTP
	id S261779AbVAKTAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:00:05 -0500
Message-ID: <41E42233.2060102@apartia.fr>
Date: Tue, 11 Jan 2005 20:00:03 +0100
From: Laurent CARON <lcaron@apartia.fr>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Unable to burn DVDs
References: <41E2F823.1070608@apartia.fr> <Pine.LNX.4.61.0501110802180.8535@yvahk01.tjqt.qr> <41E41B32.9070206@apartia.fr> <Pine.LNX.4.60.0501111943500.8024@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.60.0501111943500.8024@alpha.polcom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:

> On Tue, 11 Jan 2005, Laurent CARON wrote:
>
>> Jan Engelhardt wrote:
>>
>>>> Hello,
>>>>
>>>> I recently upgraded to 2.6.10 and tried (today) to burn a dvd with 
>>>> growisofs.
>>>>
>>>> It seems there is a problem
>>>>
>>>> Here is the output
>>>>
>>>>
>>>> # growisofs -Z /dev/scd0 -R -J ~/foobar
>>>>
>>>>
>>>
>>> I remember ide-scsi being broken now since you can use /dev/hdX 
>>> directly for writing CDs.
>>>
>>>
>>>
>> doesn't work for me
>>
>> growisofs -Z /dev/hdc -R -J ~/sendmail.mc
>> :-( unable to open64("/dev/hdc",O_RDONLY): No such device or address
>
>
> Do you have /dev/hdc?
> Also if you have scsi emulation loaded it (IIRC) eats your normal 
> device. Just try without it.
>
it is without ide-scsi

> Also there is packet cdrw/dvd+-rw driver in kernel now (2.6.10?) that 
> permits you to mount normal filesystem (for example UDF, but FAT or 
> ISO - readonly of course or EXT2 or any other but better for your 
> media without journal) on such device.

I don't want UDF
