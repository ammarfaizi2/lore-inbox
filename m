Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbTCQW1A>; Mon, 17 Mar 2003 17:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261967AbTCQW1A>; Mon, 17 Mar 2003 17:27:00 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:57099
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S261962AbTCQW06>; Mon, 17 Mar 2003 17:26:58 -0500
Message-ID: <3E764DFD.4080003@rackable.com>
Date: Mon, 17 Mar 2003 14:36:45 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Markus Peuhkuri <puhuri@netlab.hut.fi>
CC: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: 2.4.20: keyboard not present errow with HIGHMEM64G
References: <15990.9020.539010.950006@ws26.tct.hut.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Mar 2003 22:37:48.0067 (UTC) FILETIME=[D5E6FF30:01C2ECD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do

Markus Peuhkuri wrote:

>(Items correspond to template for REPORTING-BUGS)
>
>[1.] 2.4.20 does not find keyboard with HIGHMEM64G set
>
>[2.] Full description of the problem/report:
>
>AT keyboard is not regonized when booting to 2.4.20 kernel with
>HIGHMEM64G set.  Also has other problems (network configuration or
>network communication fails, which makes other diagnostics difficult).
>Also fails to detect PS2 mouse port.
>
>If the very same kernel is compiled with HIGHMEM4G, everything works. 
>
>I can do some testing, but I must give machine to productive use in a
>
>  
>

  I've seen this on a number of intel motherboards.  Try turning off 
"legacy usb" support in the bios.  This seems to "fix" the problem.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



