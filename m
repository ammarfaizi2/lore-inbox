Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbTCHUqe>; Sat, 8 Mar 2003 15:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262199AbTCHUqe>; Sat, 8 Mar 2003 15:46:34 -0500
Received: from terminus.zytor.com ([63.209.29.3]:15283 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S262198AbTCHUqc>; Sat, 8 Mar 2003 15:46:32 -0500
Message-ID: <3E6A5906.7080702@zytor.com>
Date: Sat, 08 Mar 2003 12:56:38 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "David S. Miller" <davem@redhat.com>, zippel@linux-m68k.org,
       david.lang@digitalinsight.com, rmk@arm.linux.org.uk, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303080826300.2954-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303080826300.2954-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Also, you guys should think about what this whole project was about: it's 
> about the smallest possible libc. This is NOT a project that should live 
> and prosper and grow successful. That's totally against the whole point of 
> it, it's not _supposed_ to ever be a glibc-like thing. It's supposed to be 
> so damn basic that it's not even _interesting_. It's one of those projects 
> that is better off ignored, in fact. It's like a glorified header file.
> 
> (At this point hpa asks me to shut up, since I've now depressed him more
> than any of the GPL bigots ever did ;)
> 

Hardly, since that's exactly the point :)

> I can _totally_ see hpa's point that he would be perfectly happy with
> people "stealing" parts of it - the code in question is not something that
> anybody should _ever_ have to re-create, even if he's the most evil person
> on earth and hates the GPL and wants to kill us all. Because it's not
> _worth_ recreating.

This is exactly the point.  The most interesting code in there is 
printf() and scanf(), and I'm personally utterly sick of having to 
recreate that code for various projects due to licensing incompatiblities.

	-hpa


