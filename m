Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130155AbQKJUvk>; Fri, 10 Nov 2000 15:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130425AbQKJUv3>; Fri, 10 Nov 2000 15:51:29 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:33550 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130155AbQKJUvX>; Fri, 10 Nov 2000 15:51:23 -0500
Message-ID: <3A0C5EDC.3F30BE9C@timpanogas.org>
Date: Fri, 10 Nov 2000 13:47:24 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        sendmail-bugs@sendmail.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
In-Reply-To: <Pine.LNX.3.95.1001110153916.6334A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Richard B. Johnson" wrote:
> 
>
> 
> It ran out of memory. The file got sent fine after I got rid of
> all the memory-consumers. Looks like a sendmail bug where they
> expect to load a whole file into memory all at once before sending
> it. I always thought you could read from a file, then write to
> a socket. Maybe I'm old fashioned.
> 
> Cheers,
> Dick Johnson
>

Claus,

Looks like your bug.  As an FYI, sendmail.rpms in Suse, RedHat, and
OpenLinux all exhibit this behavior, which means they're all broken. 
Reading an entire file into memory must be a BSD feature.  I have
enabled an SSH account for you, so you can come in and debug.  Richard
also can get in and will be helping.

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
