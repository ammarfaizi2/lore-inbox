Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRCPNIl>; Fri, 16 Mar 2001 08:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbRCPNIV>; Fri, 16 Mar 2001 08:08:21 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28871 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129321AbRCPNIK>;
	Fri, 16 Mar 2001 08:08:10 -0500
Message-ID: <3AB20FF0.33ADDFDD@mandrakesoft.com>
Date: Fri, 16 Mar 2001 08:06:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian May <bam@snoopy.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.2and 8139too
In-Reply-To: <Pine.LNX.4.21.0103151527420.2382-100000@ve1drg.com> <84u24ufv9h.fsf@snoopy.apana.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian May wrote:
> However, I have just put a 8139 based card into my Linux 2.4.2
> system. At one stage, these lines were logged:
> 
> Mar 15 09:42:56 snoopy kernel: eth0: Abnormal interrupt, status 00000020.
> Mar 15 09:43:04 snoopy kernel: eth0: Abnormal interrupt, status 00002020.
> Mar 15 10:06:52 snoopy kernel: eth0: Abnormal interrupt, status 00000020.
> Mar 15 10:06:58 snoopy kernel: eth0: Abnormal interrupt, status 00002020.
> 
> The card seems to be reliable apart from these messages. It could be
> that I was playing around with the network cable or something at the
> time... However, any messages "Abnormal interrupt" make me slightly
> nervous.

They are logged at the kernel debug level, but nobody seems to notice
this fact.  Oh well.  The messages are for debugging only and
informational.  They occur whenever an Rx or Tx error occurs.

The latest version of 8139too hides this message behind RTL8139_DEBUG.

	Jeff


-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
