Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUCaQqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUCaQqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:46:06 -0500
Received: from s2.org ([195.197.64.39]:43663 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id S262052AbUCaQpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:45:51 -0500
To: Petr Sebor <petr@scssoft.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [sata] libata update
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com>
	<406A8035.2080108@pobox.com> <406AB08C.1040907@scssoft.com>
From: Jarno Paananen <jpaana@s2.org>
Date: Wed, 31 Mar 2004 19:41:17 +0300
In-Reply-To: <406AB08C.1040907@scssoft.com> (Petr Sebor's message of "Wed,
 31 Mar 2004 13:50:36 +0200")
Message-ID: <m3r7v9geaa.fsf@kalahari.s2.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Sebor <petr@scssoft.com> writes:

> Jeff Garzik wrote:
>
>> Here's a potentially better patch, if you guys (or anyone else)
>> would be willing to give it a quick test...?
>>
>>     Jeff
>
> Not good at all ...
>
> (eye-copied from the console @ boot time)
>
> 2.6.5-rc3 + this patch:
>
> sata_via (0000:00:0f.0): PATA sharing not supported (0x2)
> via_sata: probe of (0000:00:0f.0) failed with error -5
>
> with following panic
>
> unable to mount root...
>
> wrt sata_via, no more messages are written...

Yup, no good here either (still 2.4-bk kernel):

libata version 1.02 loaded.
sata_via version 0.20
sata_via(00:0f.0): PATA sharing not supported (0x82)
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
SCSI device sda: 71833096 512-byte hdwr sectors (36779 MB)
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >

// Jarno
