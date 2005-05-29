Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVE2Q5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVE2Q5k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 12:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVE2Q5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 12:57:40 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:15449 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261286AbVE2Q5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 12:57:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=lIKYzNDLzooOU9TwI2sReR7r/AsYHIhUOSA6AMWMfx98y+ywjOM2/qD9P5oNgUSa1z1j1OC8Xn+4MLNL6aWSsWM2AG0FDIg6YSDRCb82FUw41on6Kiy4P8RIGflQV0aN+N7ZqjFrkfpDfhUOHL8e9PufN/0GTIM6rUJBhWCj2UA=
Message-ID: <4299F47B.5020603@gmail.com>
Date: Sun, 29 May 2005 18:57:31 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Erik Slagter <erik@slagter.name>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <1117382598.4851.3.camel@localhost.localdomain>
In-Reply-To: <1117382598.4851.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Slagter schrieb:

>On Thu, 2005-05-26 at 16:00 +0200, Jens Axboe wrote:
>  
>
>>Now, this patch is not complete. It should work and work well, but error
>>handling isn't really tested or finished yet (by any stretch of the
>>imagination). So don't use this on a production machine, it _should_ be
>>safe to use on your test boxes and for-fun workstations though (I run it
>>here...). I have tested on ich6 and ich7 generation ahci, and with
>>Maxtor and Seagate drives.
>>    
>>
>
>Is this supposed to work on ICH7 in legacy mode as well?
>
>Another question: is there a fundamental problem to have the ICH6/7
>enabled AHCI mode by the kernel instead of the BIOS? I know some BIOSes
>don't offer the choice to enable AHCI (like mine :-().
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hello,

here on my Mainboard ASUS P5WAD2-Premium (i955X/ICH7) I need to enable
AHCI support
like on the ICH6R based ASUS P5AD2-E xx the same here.
What I have noticed is when I enable Intel Raid support AHCI is on by
default, maybe it used AHCI if
drive is capable?! There are also performance regressions from within
used bios.
What mainboard are you using Erik? All mainboards with ICH6R I saw and
had (925X,925XE) offer options to enable AHCI.

Greets and best regards
 
    Michael
