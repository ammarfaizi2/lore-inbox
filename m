Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313964AbSDPX36>; Tue, 16 Apr 2002 19:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313963AbSDPX35>; Tue, 16 Apr 2002 19:29:57 -0400
Received: from [203.117.131.12] ([203.117.131.12]:17859 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S313964AbSDPX3z>; Tue, 16 Apr 2002 19:29:55 -0400
Message-ID: <3CBCB3EC.2030803@metaparadigm.com>
Date: Wed, 17 Apr 2002 07:29:48 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
MIME-Version: 1.0
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: periodic scsi hard disk noise due to regular flushes?
In-Reply-To: <7wbscjvdke.fsf@avalon.france.sdesigns.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds like TCAL (Thermal Recalibration) - some drives are quite noisy
when doing this. I had an Hitachi drive that would do this every 30
seconds once it warmed up. Could be a faulty thermo sensor on the drive.

~mc


Emmanuel Michon wrote:

>Hi,
>
>my recent IBM SCSI drive (18GB IC35L018UWD210-0) connected
>to an old Adaptec AHA-2940 UW adapter make as very 
>irritating high pitched noise (as if it were parking/unparking
>his heads?) periodically with the following intervals:
>
>1min35
>2min12
>5min03
>2min14
>1min02
>4min09
>4min14
>3min18
>1min06
>1min04
>
>It runs in ext3, journalling has commit interval set to 5sec.
>
>Does something happen in the kernel with a about 1min05 interval?
>
>Is there some way to keep it busy?
>
>My kernel is 2.4.7-10
>
>Thanks for any reply to this strange request ;-)
>


