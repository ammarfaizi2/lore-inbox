Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267592AbSLNKsA>; Sat, 14 Dec 2002 05:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267596AbSLNKsA>; Sat, 14 Dec 2002 05:48:00 -0500
Received: from angband.namesys.com ([212.16.7.85]:44946 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267592AbSLNKr7>; Sat, 14 Dec 2002 05:47:59 -0500
Date: Sat, 14 Dec 2002 13:55:50 +0300
From: Oleg Drokin <green@namesys.com>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: JDIRTY JWAIT errors in 2.4.19
Message-ID: <20021214135550.A13549@namesys.com>
References: <3DFAF9EF.6000501@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3DFAF9EF.6000501@tupshin.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Dec 14, 2002 at 01:29:19AM -0800, Tupshin Harper wrote:

> i'm getting the following error logged every 11 seconds or so:
> 
> Dec 14 01:00:49 phylum kernel: vs-3050: wait_buffer_until_released: nobody
> releases buffer (dev 16:01, size 4096, blocknr 2916352, count 3, list 0, 
> state
> 0x10019, page c1172108, (UPTODATE, CLEAN, UNLOCKED)). Still waiting
> (-1320000000) JDIRTY !JWAIT
> Also, some processes are blocking, include ps (so I can't get a complete 
> process list), and shutdown.

Can you please execute SysRq-T, decode it with ksymoops and send us the result?

> such circumstances? Is this associated with reiserfs which all 
> partitions are running? A googling turned up one or two references to 

Yes, this is reiserfs error message.

Thank you.

Bye,
    Oleg
