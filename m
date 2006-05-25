Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWEYQmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWEYQmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWEYQmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:42:46 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:47338 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1030266AbWEYQmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:42:45 -0400
Message-ID: <4475DE84.9040803@pardus.org.tr>
Date: Thu, 25 May 2006 19:42:44 +0300
From: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
User-Agent: Mozilla Thunderbird 1.5.0.2 (X11/20060426)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5 : Lots of warning in MODPOST stage
References: <44756879.2010907@pardus.org.tr> <20060525094247.0cb9d267.rdunlap@xenotime.net>
In-Reply-To: <20060525094247.0cb9d267.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=5B88F54C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote On 25-05-2006 19:42:
[...]
>> WARNING: drivers/scsi/qla1280.o - Section mismatch: reference to
>> .init.data: from .text between 'qla1280_get_token' (at offset 0x2a16)
>> and 'qla1280_probe_one'
>> WARNING: drivers/scsi/qla1280.o - Section mismatch: reference to
>> .init.data: from .text between 'qla1280_get_token' (at offset 0x2a3c)
>> and 'qla1280_probe_one'
> 
> Weird, I don't get this one either, and I used your .config file.
> However, I'll put some eyes on it.

Thanks for the reply Randy, for what its worth I used gcc 3.4.6 if that
matters.

Regards,
ismail
