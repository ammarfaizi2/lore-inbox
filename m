Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSDPKC1>; Tue, 16 Apr 2002 06:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292231AbSDPKC0>; Tue, 16 Apr 2002 06:02:26 -0400
Received: from mailhub.datafast.net.au ([203.123.67.14]:34322 "HELO
	mailhub.datafast.net.au") by vger.kernel.org with SMTP
	id <S289484AbSDPKC0>; Tue, 16 Apr 2002 06:02:26 -0400
Date: Tue, 16 Apr 2002 20:00:32 +1000
From: Wade <lkml@bigpond.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre7
Message-Id: <20020416200032.14fbd436.lkml@bigpond.com>
In-Reply-To: <slrnabnps8.evm.kraxel@bytesex.org>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Apr 2002 08:57:44 GMT
Gerd Knorr <kraxel@bytesex.org> wrote:
> error Apr 16 10:43:42 bogomips agetty[1023]: ttyS0: ioctl:
> Input/output error Apr 16 10:43:52 bogomips agetty[1025]: ttyS0:
> ioctl: Input/output error Apr 16 10:44:02 bogomips agetty[1030]:
> ttyS0: ioctl: Input/output error Apr 16 10:44:12 bogomips
> agetty[1040]: ttyS0: ioctl: Input/output error Apr 16 10:44:22
> bogomips agetty[1044]: ttyS0: ioctl: Input/output error Apr 16
> 10:44:32 bogomips agetty[1071]: ttyS0: ioctl: Input/output error Apr
> 16 10:44:42 bogomips agetty[1111]: ttyS0: ioctl: Input/output error
> Apr 16 10:44:52 bogomips init: Id "S0" respawning too fast: disabled
> for 5 minutes

Hi, I found that my ttyS0 had turned into ttyS1 :-) My modem was
unresponsive, until I changed the setting to use ttyS1, hope this helps.

(It is on the right port, I am certain. I was using ttyS0 with pre6
right before rebooting to pre7)

- Wade
