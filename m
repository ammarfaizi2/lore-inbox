Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbRA3TtA>; Tue, 30 Jan 2001 14:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132435AbRA3Tsu>; Tue, 30 Jan 2001 14:48:50 -0500
Received: from webmail.metabyte.com ([216.218.208.53]:12132 "EHLO
	webmail.metabyte.com") by vger.kernel.org with ESMTP
	id <S130516AbRA3Tsk>; Tue, 30 Jan 2001 14:48:40 -0500
Message-ID: <3A771A74.525D45AD@metabyte.com>
Date: Tue, 30 Jan 2001 11:48:04 -0800
From: Pete Zaitcev <zaitcev@metabyte.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: simon.cahuk@uni-mb.si
CC: linux-kernel@vger.kernel.org
Subject: Re: Ymfpci 724
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jan 2001 19:48:31.0382 (UTC) FILETIME=[9F7DDB60:01C08AF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Simon Cahuk (simon.cahuk@uni-mb.si)
> Date: Tue Jan 30 2001 - 14:22:26 EST 
> 
> I have a ymfpci sound chip on my motherboard. I'm using ymfpci module. 
> Under Q3A I get this: 
> sound inilializations: 
> Sorry but your soundcard can't do this 

Probably an mmap-ed sound problem or some ioctl is not implemented.
Q3A is on my YMF list, behind power management. Please feel free
to investigate it yourself and send any patches.

Another thing that you can do is to try to use ALSA. I think
that ALSA driver is superior for most cases because
my ymfpci code is based on Jaroslav's ALSA code and
will be replaced by ALSA eventually.

-- Pete
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
