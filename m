Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWELPvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWELPvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWELPvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:51:13 -0400
Received: from web52903.mail.yahoo.com ([206.190.49.13]:8837 "HELO
	web52903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751291AbWELPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:51:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=k85LZhMwDzv162xzo+3ZUL3vdb5+Rde40oYDP0DiU3J/8oMSmMq5Gzglpum8WDLL+bjBV0KRyyXoKI7geIAeXquT+3W6S9FCJd9riz/Yxbq8w/l/04ktBT5CjQRNj/TfzeFdTctcVuPl1OB7YhFneSJHAd2UoNHvUxsLorqQXKU=  ;
Message-ID: <20060512155107.20047.qmail@web52903.mail.yahoo.com>
Date: Fri, 12 May 2006 08:51:07 -0700 (PDT)
From: Winn Johnston <winn_johnston@yahoo.com>
Subject: Re: BUG: soft lockup detected on CPU#0!
To: linux-kernel@vger.kernel.org
In-Reply-To: <20060511180320.49788.qmail@web52901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed another post the other day, and contacted
the indavidual who posted it. note his message below.

Hi Winn,
Latest news i had was a *hint* from Andrew Morton
telling me to try with kernel 2.6.17-rc3 and report if
the problem was gone or not. I've had no 
time to give it a try yet.Your problem seems similar
to mine, a few person argued that the message 
was bogus and that no harm was done but i guess they
did not read carefully the post since the consequences
are pretty bad.
Let me know if you manage to try with the latest rc of
the 2.6.17 kernel and if things are better.

ref:
http://groups.google.com/group/linux.kernel/browse_thread/thread/450966ffa3043609/59e6a2350b7690bf?lnk=st&q=kernel%3A+ide%3A+failed+opcode+was%3A+0xea%22+BUG%3A+soft+lockup+detected+on+CPU%230!%22&rnum=1&hl=en#59e6a2350b7690bf

--- Winn Johnston <winn_johnston@yahoo.com> wrote:

> Error:
> 
> kernel: hdi: drive_cmd: status=0xd0 { Busy }
> kernel: ide: failed opcode was: 0xea
> BUG: soft lockup detected on CPU#0!
> 
> the odd thing is the system experiences a hard
> lockup,
> so it is not a false positive. I am working on a
> trace, but it is hard to get.
> 
> My supervisor has asked me to help research this
> problem. We are using multiple ata cards in our
> backup
> machine. We have a Promiss sata 300tx4, and three
> ATA
> cards (3 SIG UltraATA 133 PCI) or (3 promise ultra
> 100tx2). We are experiencing hard lockups. The
> system
> resides on a scsi drive connected to the on board
> controler Adaptec AIC-7899P (Tyan S2462
> motherboard)the error is repeated for all drives
> connected to the promis cards, and the error
> continues
> until a lock up is eventualy reached.
> 
> Also, its in dma mode, not pio.
> PREEMPT_NONE is already set, so its not the
> preemption
> model
> 
> possibly related posts
>
http://www.ussg.iu.edu/hypermail/linux/kernel/0309.1/0444.html
> 
>
http://groups.google.com/group/linux.kernel/browse_thread/thread/450966ffa3043609/59e6a2350b7690bf?lnk=st&q=kernel%3A+ide%3A+failed+opcode+was%3A+0xea%22+BUG%3A+soft+lockup+detected+on+CPU%230!%22&rnum=1&hl=en#59e6a2350b7690bf
> 
> 
> 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> http://mail.yahoo.com 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
