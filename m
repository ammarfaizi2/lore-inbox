Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137093AbREKKAC>; Fri, 11 May 2001 06:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137095AbREKJ7w>; Fri, 11 May 2001 05:59:52 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:36416 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S137093AbREKJ7d>; Fri, 11 May 2001 05:59:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marcin Kowalski <kowalski@datrix.co.za>
Reply-To: kowalski@datrix.co.za
Organization: Datrix Solutions
To: bob-linux@technogeeks.com
Subject: Re: 8GB large memory slowdowns (possible mtrr problem)
Date: Fri, 11 May 2001 11:59:39 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.30.0105101545260.25422-300000@why.ak.technogeeks.co>
In-Reply-To: <Pine.LNX.4.30.0105101545260.25422-300000@why.ak.technogeeks.co>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01051111593905.07057@webman>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am experiencing a very similar problem with a dual 933mhz Hp Netserver with 
a Serverworks Motherboard.

I only have 1.2gig of RAM so I use the 4GIG mem option, the server crashed 
yesterday after two weeks of uptime with the error BUG at Highmem.c :155 .  
It is running Kernel 2.4.3.... as per my other post...

I have seen this problem come up a number of times with as yet no solution. I 
initially found a large amount of memory (/etc/slabinfo) used by icache and 
dcache entries.  As a result a patch was released to fix this but the problem 
remains... random freezes for a number of seconds while editing a file, 
viewing a directory, etc.. ?? HELP

MARCin


-----------------------------
     Marcin Kowalski
     Linux/Perl Developer
     Datrix Solutions
     Cel. 082-400-7603
      ***Open Source Kicks Ass***
-----------------------------
