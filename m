Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSI2Asp>; Sat, 28 Sep 2002 20:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262361AbSI2Asp>; Sat, 28 Sep 2002 20:48:45 -0400
Received: from web40808.mail.yahoo.com ([66.218.78.185]:21547 "HELO
	web40808.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262360AbSI2Aso>; Sat, 28 Sep 2002 20:48:44 -0400
Message-ID: <20020929005401.44840.qmail@web40808.mail.yahoo.com>
Date: Sat, 28 Sep 2002 17:54:01 -0700 (PDT)
From: Venkatesh Rao <rpranesh@yahoo.com>
Subject: Re: Problems with tcp_retransmit_skb - Please omit the previous incomplete mail
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209271451.SAA21049@sex.inr.ac.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey:
Indeed it was a network driver problem. The circular
buffer queue full condition check was not coded
properly. I will send a patch to Greg Ungerer
correcting this issue.

Thanks a lot for the pointer.
Cheers,
Venkatesh
--- kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > This is the only socket which *sends* relatively
> huge
> 
> ... loses enough of date to overflow, all the rest
> leak a bit and
> silently, until all the memory exhausts and machine
> dies. :-)
> 
> 
> > Can this still be a network driver problem?
> 
> No doubts, it is.
> 
> Alexey


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
