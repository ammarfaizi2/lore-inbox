Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSHGCCI>; Tue, 6 Aug 2002 22:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSHGCCH>; Tue, 6 Aug 2002 22:02:07 -0400
Received: from goshen.rutgers.edu ([165.230.180.150]:35822 "HELO
	goshen.rutgers.edu") by vger.kernel.org with SMTP
	id <S317023AbSHGCCB>; Tue, 6 Aug 2002 22:02:01 -0400
Date: Tue, 6 Aug 2002 22:05:40 -0400 (EDT)
From: Vasisht Tadigotla <vasisht@eden.rutgers.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: multiple connect on a socket
In-Reply-To: <Pine.GSO.4.21.0208062103210.4158-100000@er3.rutgers.edu>
Message-ID: <Pine.GSO.4.21.0208062205130.8961-100000@er3.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sorry, for replying to my own mail. the kernel version is 2.4.18

vasisht

On Tue, 6 Aug 2002, Vasisht Tadigotla wrote:

> 
> Hi,
> 
> i'm doing the following steps,
> 
> 1. open a socket on some remote server
> 2. set it to be non-blocking
> 3. connect to that socket
> 4. do a select on the socket
> 5. read from the socket
> 6. connect to the socket again
> 7. read from the socket
> 
> and as expected a EINPROGRESS error is thrown on step 3. After I do a
> select() and read from that socket, I try to connect to it again and it
> connects without throwing an EISCONN error in linux, though if I try to
> read from it it throws a EAGAIN error. Shouldn't it throw an error when I
> try to connect to it a second time ? Am I missing something here.
> 
> 
> Vasisht
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

---------------------------------------------------------------------
ce .sig n'est pas une .sig

