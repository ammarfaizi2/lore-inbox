Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130429AbQKJUcZ>; Fri, 10 Nov 2000 15:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130841AbQKJUcI>; Fri, 10 Nov 2000 15:32:08 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:25870 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130429AbQKJUbr>; Fri, 10 Nov 2000 15:31:47 -0500
Message-ID: <3A0C5A41.16EEAE78@timpanogas.org>
Date: Fri, 10 Nov 2000 13:27:45 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
In-Reply-To: <20001110205129.A4344@inspiron.suse.de> <Pine.LNX.3.95.1001110150021.5941A-100000@chaos.analogic.com> <20001110212156.A4568@inspiron.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:
> 
> On Fri, Nov 10, 2000 at 03:07:46PM -0500, Richard B. Johnson wrote:
> > It isn't a TCP/IP stack problem. It may be a memory problem. Every time
> > sendmail spawns a child to send the file data, it crashes.  That's
> > why the file never gets sent!
> 
> Sure that could be the case. You should be able to verify the kernel kills the
> task with `dmesg`.
> 
> However Jeff said the problem happens over 400K and a 500K attachment shouldn't
> really run any machine out of memory, so maybe this wasn't his same problem?

I think it is.  So it looks like sendmail is bombing when it attempts to
send large files. 

Jeff 

> 
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
