Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277897AbRJISnt>; Tue, 9 Oct 2001 14:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277896AbRJISnj>; Tue, 9 Oct 2001 14:43:39 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:9991 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277897AbRJISnV>; Tue, 9 Oct 2001 14:43:21 -0400
X-Apparently-From: <trever?adams@yahoo.com>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
From: "Trever L. Adams" <trever_adams@yahoo.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <006401c150e9$90198c40$839183a0@W20303512>
In-Reply-To: <1002646705.2177.9.camel@aurora> 
	<006401c150e9$90198c40$839183a0@W20303512>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 09 Oct 2001 14:43:42 -0400
Message-Id: <1002653054.3352.3.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-09 at 13:40, Wilson wrote:
> This is someone on the outside scanning you for Back Orifice. I don't
> understand why this is supposed to be a valid connection.
> >From your iptables output, it looks like your rules are working properly.
> (They aren't set up exactly how I would have done it, but it's all a matter
> of style.)
> Can you give a more specific example of something that it being DROPped when
> it shouldn't be?
> 
> --Wilson.
> 

Sure thing.  I suppose I should have chosen a connection better from the
logs.  These were valid connections to digitalme.com on pop3 (I think or
is that smtp...).  Happens with web connections to there and other
places as well.

Oct  9 13:27:05 smeagol kernel: Firewall:IN=ppp0 OUT= MAC=
SRC=193.97.97.75 DST=209.237.196.198 LEN=40 TOS=0x00 PREC=0x00 TTL=116
ID=6369 DF PROTO=TCP SPT=110 DPT=2213 WINDOW=0 RES=0x00 ACK RST URGP=0 
Oct  9 13:31:44 smeagol kernel: Firewall:IN=ppp0 OUT= MAC=
SRC=193.97.97.75 DST=209.237.196.198 LEN=40 TOS=0x00 PREC=0x00 TTL=116
ID=13344 DF PROTO=TCP SPT=110 DPT=2220 WINDOW=0 RES=0x00 ACK RST URGP=0 
Oct  9 13:39:03 smeagol kernel: Firewall:IN=ppp0 OUT= MAC=
SRC=193.97.97.75 DST=209.237.196.198 LEN=40 TOS=0x00 PREC=0x00 TTL=116
ID=26891 DF PROTO=TCP SPT=110 DPT=2251 WINDOW=0 RES=0x00 ACK RST URGP=0 
Oct  9 13:47:16 smeagol kernel: Firewall:IN=ppp0 OUT= MAC=
SRC=193.97.97.75 DST=209.237.196.198 LEN=40 TOS=0x00 PREC=0x00 TTL=116
ID=41385 DF PROTO=TCP SPT=110 DPT=2254 WINDOW=0 RES=0x00 ACK RST URGP=0 


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

