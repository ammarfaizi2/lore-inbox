Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319598AbSILROg>; Thu, 12 Sep 2002 13:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319600AbSILROg>; Thu, 12 Sep 2002 13:14:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:8076 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319598AbSILROf>;
	Thu, 12 Sep 2002 13:14:35 -0400
Message-ID: <1031851117.3d80cc6d8c8e0@imap.linux.ibm.com>
Date: Thu, 12 Sep 2002 10:18:37 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: Todd Underwood <todd@osogrande.com>
Cc: "David S. Miller" <davem@redhat.com>, "hadi@cyberus.ca" <hadi@cyberus.ca>,
       "tcw@tempest.prismnet.com" <tcw@tempest.prismnet.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <Pine.LNX.4.44.0209120119580.25406-100000@gp>
In-Reply-To: <Pine.LNX.4.44.0209120119580.25406-100000@gp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.47.18.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Todd Underwood <todd@osogrande.com>:

> sorry for the late reply.  catching up on kernel mail.

> the main different, though, is that general purpose kernel
> development still focussed on the improvements in *sending* speed.
> for real high performance networking, the improvements are necessary
> in *receiving* cpu utilization, in our estimation. 
> (see our analysis of interrupt overhead and the effect on receivers
> at gigabit speeds--i hope that this has become common understanding
> by now)

Some of that may be a byproduct of the "all the worlds' a webserver"
mindset - we are primarily focussed on the server side (aka
money side ;)), and there is some amount of automatic thinking that
this means we're going to be sending data and receiving small packets,
mostly acks) in return. There is much less emphasis given to solving
the problems on the other side (active connection scalability for 
instance), or other issues that manifest themselves as 
client side bottlenecks for most applications..

thanks,
Nivedita

