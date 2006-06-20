Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWFTPMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWFTPMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWFTPMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:12:25 -0400
Received: from www.osadl.org ([213.239.205.134]:6589 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751303AbWFTPMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:12:24 -0400
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>
	 <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 17:13:49 +0200
Message-Id: <1150816429.6780.222.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 17:01 +0100, Esben Nielsen wrote:
> Hi,
>   I wanted to run some tests with RTExec and I wanted to play around with 
> the priorities, but I could not set the priorities of softirq-hrtXXXX.
> I looked a bit in the code and found that hrtimer_adjust_softirq_prio() is
> called every loop, setting it back to priority 1.
> 
> Why is that? Can it be fixed so it behaves as any other task you can use 
> chrt on?

No, please see

http://www.linutronix.de/index.php?mact=News,cntnt01,detail,0&cntnt01articleid=8&cntnt01dateformat=%25b%20%25d%2C%20%25Y&cntnt01returnid=31
        
Dynamic priority support for high resolution timers
        
	tglx
        

