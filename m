Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbTJ0Otp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 09:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTJ0Oto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 09:49:44 -0500
Received: from mail.broadpark.no ([217.13.4.2]:6393 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S263151AbTJ0Otn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 09:49:43 -0500
Cc: jgarzik@pobox.com
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6t9 SATA slower than 2.4.20
References: <3F9D196C.9080301@savages.net> <3F9D233D.6000409@pobox.com>
Message-ID: <oprxph3ru9q1sf88@mail.broadpark.no>
From: Arve Knudsen <aknuds-1@broadpark.no>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Mon, 27 Oct 2003 15:48:53 +0100
In-Reply-To: <3F9D233D.6000409@pobox.com>
User-Agent: Opera7.21/Linux M2 build 480
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003 08:53:01 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:

> Shaun Savage wrote:
>> I have just compiled and installed kernel 2.6t9 on my RH9 / Asus A7N8X 
>> Deluxe.  I find the disk access is slower using the 2.6 kernel than the 
>> 2.4.20 kernel.
>>
>> To get it to work for 2.4.20 kernel I have to use
>> # hdparm -d1 -X88 /dev/hde
>> then the buffered disk read goes from 1.5M to 55M
>>
>> On the 2.6 kernel the buffered disk read is only 16M
>>
>> What do I have to do to increase the disk speed for kernel 2.6t9?
>
>
> Are you using CONFIG_SCSI_SATA in 2.6?

Should this make a difference speedwise with SiI 3112? I have one Maxtor 
120GB, and one Seagate 120GB each attached to the SiI controller (Mobo: 
Asus A7N8X Deluxe). The Seagate (my main drive) is as slow as ever (since 
DMA was turned on by default, ~13MB/s), although hdparm reports better 
numbers for the Maxtor (~33MB/s).

Regards

Arve Knudsen
