Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbTAWCMA>; Wed, 22 Jan 2003 21:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTAWCMA>; Wed, 22 Jan 2003 21:12:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45326 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264822AbTAWCL7>;
	Wed, 22 Jan 2003 21:11:59 -0500
Message-ID: <3E2F5137.30506@pobox.com>
Date: Wed, 22 Jan 2003 21:19:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jacek Radajewski <jacek@usq.edu.au>
CC: Seth Mos <knuffie@xs4all.nl>, linux-poweredge@dell.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN
References: <08D7835AE15D6F4BABB5C46427F018DF0E608E@babbage.usq.edu.au>
In-Reply-To: <08D7835AE15D6F4BABB5C46427F018DF0E608E@babbage.usq.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek Radajewski wrote:
> is the network card really the problem ?  I don't want to be replacing all my network cards if the problem is elsewhere .... if you can understand the oops message please, please, please let me know where the problem is ...

> Trace; c01ac741 <start_request+1a1/210>
> Trace; c01acacc <ide_do_request+29c/2f0>
> Trace; c01acf99 <ide_intr+129/160>
> Trace; f897f2f0 <.data.end+6cf1/????>
> Trace; c010a61e <handle_IRQ_event+5e/90>
> Trace; c010a852 <do_IRQ+c2/110>
> Trace; c0106e60 <default_idle+0/40>
> Trace; c0105000 <_stext+0/0>
> Trace; c010d058 <call_do_IRQ+5/d>
> Trace; c0106e60 <default_idle+0/40>
> Trace; c0105000 <_stext+0/0>
> Trace; c0106e8c <default_idle+2c/40>
> Trace; c0106ef4 <cpu_idle+24/30>


nope, that trace has nothing to do with the network stack or net card...

	Jeff



