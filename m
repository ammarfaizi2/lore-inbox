Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266853AbSKOWYq>; Fri, 15 Nov 2002 17:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266841AbSKOWYm>; Fri, 15 Nov 2002 17:24:42 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:13453 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266849AbSKOWXX>; Fri, 15 Nov 2002 17:23:23 -0500
Message-ID: <3DD57568.CC9CC2CC@us.ibm.com>
Date: Fri, 15 Nov 2002 14:30:01 -0800
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: arcot_arumugam@hotmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: TCPPureAcks TCPHPAcks - Definition?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am browsing linux TCP MIB header code and I see many fields but no
> explanation on what those fields are.
> 
> Some of them are obvious but others are not.
> 
> you can see all of them by typing
> 
> /proc/net/netstat
> 
> Does anyone know about what these fields contain? Is it documented anywhere?
> 
> I did a google but could not find anything.

TCPHPAcks - An ack received in TCP fast path. i.e. 
	    header prediction path. In sequence ack
	    that moves the window. See tcp_ack()
	    in tcp_input.c.

TCPPureAcks - Pure ack recvd (i.e. no data was sent).
            This excludes the above category.


I am working on documenting this stuff. Probably a couple
of weeks away. 

I also suggest posting to netdev@oss.sgi.com, which is the
mailing list targeted to networking developers, or even
linux-net@vger.kernel.org, which is the mailing list most
networking users post problem reports and questions on.
Your chances of reaching a networking person who has time to
answer the question are greater :).

thanks,
Nivedita
