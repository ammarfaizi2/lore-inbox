Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWKBRUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWKBRUT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWKBRUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:20:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:17833 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750747AbWKBRUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:20:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AknhTxPYPadFUmNNLD49DM/HAui/ovb9qChQvCZod2VJKgGcN/jY0/H0m3yWBhUUH/nuyKE+VTKeF9LEM3GTIdXoP5P0LeRrXKJdKUiH0wgJl5JhkqaokarJQSwK7Du0FXEZeBr2Jzkpo5Wb0jP1egYAMclRqo60HFOAr2DFqVQ=
Message-ID: <454A28CB.1030002@gmail.com>
Date: Thu, 02 Nov 2006 21:20:11 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hdb lost interrupt
References: <4549B305.7040106@gmail.com>	 <1162473087.11965.182.camel@localhost.localdomain>	 <454A0F2B.5060603@gmail.com> <1162482682.11965.202.camel@localhost.localdomain>
In-Reply-To: <1162482682.11965.202.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-11-02 am 19:30 +0400, ysgrifennodd Manu Abraham:
>> running smartctl -a gave me this ..
> 
> Thanks
> 
>> [17207074.632000] hdd: command error: status=0x51 { DriveReady
>> SeekComplete Error }
>> [17207074.632000] hdd: command error: error=0x54 { AbortedCommand
>> LastFailedSense=0x05 }
> 
> CD stuff so not related.
> 
>> [17207531.412000] hdb: dma_intr: status=0x30 { DeviceFault SeekComplete }
>> [17207531.412000] ide: failed opcode was: unknown
>> [17207531.412000] hda: DMA disabled
>> [17207531.412000] hdb: DMA disabled
>> [17207534.628000] ide0: reset: success
>> [17208781.840000] hdb: drive_cmd: status=0x30 { DeviceFault SeekComplete }
>> [17208781.840000] ide: failed opcode was: 0xb0
> 
> No idea, it appears the drive got cross and went for a sulk but I've no
> idea why and the diagnostics aren't sufficient to tell
> 

Is there something that i can look out for, such that debugging this
would be easier ?


Thanks,
Manu


