Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270498AbRHHOjF>; Wed, 8 Aug 2001 10:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270499AbRHHOiz>; Wed, 8 Aug 2001 10:38:55 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:46742 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S270498AbRHHOig> convert rfc822-to-8bit; Wed, 8 Aug 2001 10:38:36 -0400
Importance: Normal
Subject: Re: BUG: Assertion failure with ext3-0.95 for 2.4.7
To: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF1F8FDF9C.400E6F0B-ONC1256AA2.004F74C5@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Wed, 8 Aug 2001 16:38:36 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 08/08/2001 16:38:35
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> >It would be interesting to know if this still happends without a beta
>> >version of LVM,
>> >and without LVM at all.
>>
>> I will try it. But if I mount the same file system as ext2 (mount ... -t
>> ext2) the test succeeds, so I guess it is not LVM specific. I will
inform
>> you if I know the result.
>
>Well ext3 has more debugging checks than ext3 at the moment, and also
requires the
>underlying blocklayers (LVM/RAID etc) to not lie. So the test _IS_
relevant,
>not to caste blame, but to find the interaction.....

OK.I tested it with a single 2GB disk without LVM and there was no error.

I also tested it with a 70GB LVM and /proc/sys/fs/jbd-debug set to 5.There
was also no error. After reset to 0 the error reoccured (???)
Next, I will try,using md instead of LVM to have a disk with a similar
size.

greetings

Christan Bornträger



