Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270831AbTHFRSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270828AbTHFRSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:18:16 -0400
Received: from pl914.nas911.n-yokohama.nttpc.ne.jp ([210.139.42.146]:5317 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id S270822AbTHFRSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:18:12 -0400
Message-ID: <3F3138C7.2040404@yk.rim.or.jp>
Date: Thu, 07 Aug 2003 02:20:07 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Paul Blazejowski <paulb@blazebox.homeip.net>
CC: wb <dead_email@nospam.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Patrick Mansfield <patmans@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Badness in device_release at drivers/base/core.c:84
References: <20030801182207.GA3759@blazebox.homeip.net>	 <20030801144455.450d8e52.akpm@osdl.org>	 <20030803015510.GB4696@blazebox.homeip.net>	 <20030802190737.3c41d4d8.akpm@osdl.org>	 <20030803214755.GA1010@blazebox.homeip.net>	 <20030803145211.29eb5e7c.akpm@osdl.org>	 <20030803222313.GA1090@blazebox.homeip.net>	 <20030803223115.GA1132@blazebox.homeip.net>	 <20030804093035.A24860@beaverton.ibm.com>	 <1060021614.889.6.camel@blaze.homeip.net>	 <1352160000.1060025773@aslan.btc.adaptec.com>	 <5793.199.181.174.146.1060050091.squirrel@www.blazebox.homeip.net>	 <3F2F84D2.8000202@nospam.com>  <3F2FD6ED.1005BB2C@yk.rim.or.jp> <1060189107.887.7.camel@blaze.homeip.net>
In-Reply-To: <1060189107.887.7.camel@blaze.homeip.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Kermit was very helpful but due to my inexperience i was not able to get
> the log due to Linux's box resetting of /dev/ttyS0 when booting, i would
> get disconnect...
> 

Oh, I forgot some details. You might be able to
circumvent the problem by
issueing
set carrier-watch off

I use the direct-wire connetion with
a device from a Linux PC's tty port using ckermit and
so let me check the setup again tomorrow at the office.

> Thanks a lot for suggesting ckermit.
> 
> Regards,
> 
> Paul B.


-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */

