Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317658AbSFMPKv>; Thu, 13 Jun 2002 11:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317661AbSFMPKu>; Thu, 13 Jun 2002 11:10:50 -0400
Received: from mm02snlnto.sandia.gov ([132.175.109.21]:55058 "HELO
	mm02snlnto.sandia.gov") by vger.kernel.org with SMTP
	id <S317658AbSFMPKt>; Thu, 13 Jun 2002 11:10:49 -0400
X-Server-Uuid: 95b8ca9b-fe4b-44f7-8977-a6cb2d3025ff
Message-ID: <03781128C7B74B4DBC27C55859C9D73809840636@es06snlnt>
From: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: TCP checksum?
Date: Thu, 13 Jun 2002 09:10:46 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-Filter-Version: 1.8 (sass2426)
X-WSS-ID: 11166A091123536-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for a function similar to skb_checksum(), but
for the tcphdr->check field. I'm playing around with a module
I've written for netfilter and I would like to modify options of
the IP and TCP headers. For example, right now I'm trying
to set the destination IP to the source IP, but the TCP checksum
is coming out incorrectly. How can I calculate this checksum?

Thanks a lot in advance. Also, if anyone knows where some
documentation about the TCP/IP stack in the kernel are, please
let me know.

Jeff Shipman - CCD
Sandia National Laboratories
(505) 844-1158 / MS-1372


