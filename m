Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281262AbRKER6P>; Mon, 5 Nov 2001 12:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281263AbRKER6H>; Mon, 5 Nov 2001 12:58:07 -0500
Received: from dispatch.lakeheadu.ca ([216.211.0.8]:1298 "HELO
	dispatch.lakeheadu.ca") by vger.kernel.org with SMTP
	id <S281262AbRKER6C>; Mon, 5 Nov 2001 12:58:02 -0500
Message-ID: <3BE6D27D.6020305@mail.myrealbox.com>
Date: Mon, 05 Nov 2001 12:55:09 -0500
From: "Daniel R. Warner" <drwarner@mail.myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.5) Gecko/20011019
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Poor IDE performance with VIA MVP3
In-Reply-To: <20011105005033.A10060@isis.visi.com> <01110516120000.00794@nemo> <20011105114242.A8099@isis.visi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Hayle wrote:

> hdparm -T (buffer-cache reads) gives good numbers, 43v69 M/sec just
> now.

<snip>


> It's sounding more and more like this isn't a driver/chipset problem, but
> something wrong with the HD itself.  Thanks for your insight.

I think that this is probably the case. I just tested a Maxtor drive on 
a MVP3 on 2.4.12-ac6, 2.4.13-ac7, and 2.4.14-pre8 (all with the preempt 
patch applied) and get ~8.5MB/sec on buffered disk reads, and ~55MB/sec 
on buffer-cache reads.

-D


