Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310483AbSCSXMM>; Tue, 19 Mar 2002 18:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310458AbSCSXLx>; Tue, 19 Mar 2002 18:11:53 -0500
Received: from lsanca1-220-085.lsanca1.dsl.gtei.net ([4.3.220.85]:43536 "EHLO
	vhost2.connect4less.com") by vger.kernel.org with ESMTP
	id <S310295AbSCSXLs>; Tue, 19 Mar 2002 18:11:48 -0500
Message-ID: <3C97AF8A.20705@connect4less.com>
Date: Tue, 19 Mar 2002 13:37:14 -0800
From: "David Christensen" <davidc@connect4less.com>
Organization: Connect4Less, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible problem with isofs and CONFIG_NOHIGHMEM 2.4.17
In-Reply-To: <3C95417E.B9BFAF68@connect4less.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Repost, no response from first post!

David Christensen wrote:

> Posted this to the fsdevel list, but didn't get any bites!
> 
> 
> After a search through the FAQ to see if this was a known issue, I
> thought I should report it!
> 
> Just brought my system up to 1G of ram (1.2GHz Athlon, Abit KT7MB, 1GB
> RAM, Adaptec 29160N, eepro100, SndBlstr Live) and thought I should
> recompile the kernel to allow for "HIGHMEM" (4GB.)  After the compile, I
> noticed I couldn't mount any CD's.  For some reason the ISO9660 driver
> was getting stomped.  
> 
> I have ISO9660 compiled as a module, but it seems to be hosed with the
> HIGHMEM setting in the kernel.  Changed HIGHMEM back to "off" and
> ISO9660 support came back.  Kernel version = 2.4.17 stock.
> 
> Any reason why?
> 
> Thanks for your response,
> 
> David Christensen
> 


