Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTDKVs5 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTDKVs5 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:48:57 -0400
Received: from [195.82.114.197] ([195.82.114.197]:65030 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id S261840AbTDKVs4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 17:48:56 -0400
Date: Fri, 11 Apr 2003 23:00:39 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Mike Dresser <mdresser_l@windsormachine.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net, message-bus-list@redhat.com,
       Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <290394184.1050102039@[192.168.100.8]>
In-Reply-To: <Pine.LNX.4.33.0304111553380.14943-100000@router.windsormachine.com>
References: <Pine.LNX.4.33.0304111553380.14943-100000@router.windsormachine.
 com>
X-Mailer: Mulberry/2.2.1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On 11 April 2003 15:59 -0400 Mike Dresser <mdresser_l@windsormachine.com> 
wrote:

>  now have 1 + 3 + 9 = 13 splitters, giving me 27 connections, out of 1.
> etc, etc. Same numbers I'd have doing it your way, yours would be 13
> levels deep instead.
>
> I think I just went for the massively parallel method of hooking
> these up and from there got massively lost.

Your 13 splitters have each added 2 connections to the 1, giving
1 + 13 x 2 = 27. There is no multiplicative effect.

Similarly to get to 4000 drives from 5, you need to add 3995
connections, i.e. 1998 splitters (giving one spare for the
floppy/cdrom).

--
Alex Bligh
