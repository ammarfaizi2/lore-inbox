Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263002AbRFLSVW>; Tue, 12 Jun 2001 14:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263003AbRFLSVL>; Tue, 12 Jun 2001 14:21:11 -0400
Received: from james.kalifornia.com ([208.179.59.2]:29790 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S263002AbRFLSU7>; Tue, 12 Jun 2001 14:20:59 -0400
Message-ID: <3B265D08.30507@blue-labs.org>
Date: Tue, 12 Jun 2001 11:18:48 -0700
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-ac12 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
To: Michal Margula <alchemyx@uznam.net.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disaster under heavy network load on 2.4.x
In-Reply-To: <20010611220301.A6852@cerber.uznam.net.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like you don't have 'lo' configured, i.e. your 127.0.0.1 interface.

David

Michal Margula wrote:

>Hello!
>
>My friend told me to noticed you about problems I had with 2.4.x line of
>kernels. I started up from 2.4.3. Under heavy load I was getting
>messages from telnet, ping, nmap "No buffer space available". Strace
>told me it was error marked as ENOBUFS.
>
>First thought was it was my fault. I asked many people and nobody could
>help me. So I tried 2.4.5. It was a disaster also (should I mention few
>oopses?:>).
>
>Second thought was to try 2.2.19 and it was good choice. Now there are
>almost no messags like those above. Only thing that still happens is
>"Neihgbour table overflow".
>
>Some data about my Linux box:
>
>2 x PIII 800 MHz/1024 MB; 2 x Intel EExpres 100; 3 x 3com 3c900B-Combo.
>Summarizing all traffic about 5mbit at the moment.
>
># arp -an | wc -l
>   1018
>
>Any more info needed?
>
>PS. It would be nice to be CCed with replies, beacause I am not
>subscribed to LKML.
>


