Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264242AbRFHRLT>; Fri, 8 Jun 2001 13:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264244AbRFHRLK>; Fri, 8 Jun 2001 13:11:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9745 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264242AbRFHRK4>; Fri, 8 Jun 2001 13:10:56 -0400
Subject: Re: tcp_recvmsg() in 2.4.4
To: davem@redhat.com (David S. Miller)
Date: Fri, 8 Jun 2001 18:08:53 +0100 (BST)
Cc: eric@bartonsoftware.com (Eric Barton), linux-kernel@vger.kernel.org
In-Reply-To: <15136.61263.7046.76298@pizda.ninka.net> from "David S. Miller" at Jun 08, 2001 08:29:19 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E158Pkj-0002wD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Actually I'd really appreciate it if someone could explain the order of
>  > tests for sk->done, sk->err, sk->shutdown and sk->state...
> 
> Most of the error test ordering is specified by POSIX somewhere.

I ordered them that way to match the list given in the posix 1003.1g draft 6.4
specification. 

