Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275853AbRJKJmm>; Thu, 11 Oct 2001 05:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275856AbRJKJmc>; Thu, 11 Oct 2001 05:42:32 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:8131 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S275853AbRJKJmO>;
	Thu, 11 Oct 2001 05:42:14 -0400
Date: Thu, 11 Oct 2001 13:42:08 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jianyong Zhang <jzhang@cse.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a problem about non-linear sk_buff
Message-Id: <20011011134208.31535158.johnpol@2ka.mipt.ru>
In-Reply-To: <Pine.SOL.4.33.0110092342190.24061-100000@frack.cse.psu.edu>
In-Reply-To: <Pine.SOL.4.33.0110092342190.24061-100000@frack.cse.psu.edu>
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.9; Linux 2.4.9; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001 23:51:17 -0400 (EDT)
Jianyong Zhang <jzhang@cse.psu.edu> wrote:

JZ> Hi,

JZ> I'm a newcomer of this list.  I want to understand the tcp/ip stack's
JZ> implementaion, and hope that I can get your help.

kernlel-net is also good for this kind of questions.

JZ> I find that that sk_buff can be fragmented, and it's called nonlinear.
JZ> What's the meaning of nonlinear?  And what are the meaning of
sk_buff's

May be because of MTU?

JZ> fields: skb->data_len and skb_shinfo(skb)?  I have no idea about them.

As I've right understood it from 
www.linux.org.uk/Documents/buffers.html (excellent Alan's book)
http://kernelnewbies.org/documents/ipnetworking/linuxipnetworking.html
(the best source of documentation fobeginners)
and skbuff.h
skb->data_len is actuall length of the data( that is all packet length -
header length).

skb_shinfo(skb) returns structure that containig number of fragments, list
of it, and some other( what? ).

JZ> May you explain them?  Thank you.

I'm trying, but it can be absolutelly wrong :)

JZ> Jianyong Zhang

Evgeniy Polyakov.
---
WBR. //s0mbre
