Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291727AbSBAMAD>; Fri, 1 Feb 2002 07:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291729AbSBAL7x>; Fri, 1 Feb 2002 06:59:53 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:20197 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S291727AbSBAL7m>; Fri, 1 Feb 2002 06:59:42 -0500
Message-ID: <3C5A8329.2060701@reviewboard.com>
Date: Fri, 01 Feb 2002 12:59:37 +0100
From: Chris Chabot <chabotc@reviewboard.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020201
X-Accept-Language: en,nl
MIME-Version: 1.0
To: Joe Wong <joewong@tkodog.no-ip.com>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 cannot connect to www.sun.com
In-Reply-To: <Pine.LNX.4.21.0202011939150.30567-100000@dog.ima.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try echo 0 > /proc/sys/net/ipv4/tcp_ecn

I dont know, but ecn can prevent you from reaching some locations on the 
net.. could be that 2.4.17 turns it on by default.

    -- Chris


Joe Wong wrote:

>Hello all,
>
>  For some reason after I upgraded to 2.4.16, I cannot connect to
>www.sun.com anymore. It also happens on some other sites. Anyone know what
>might be the problem? I have no problem using 2.4.7.
>
>TIA.
>
>- Joe
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



