Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276594AbRI2TX5>; Sat, 29 Sep 2001 15:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276596AbRI2TXr>; Sat, 29 Sep 2001 15:23:47 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:20774 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S276594AbRI2TXg>; Sat, 29 Sep 2001 15:23:36 -0400
Date: Sat, 29 Sep 2001 20:27:52 +0100
From: Steve Maughan <saxm@dcs.ed.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: George Garvey <tmwg-linuxknl@inxservices.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac10 IDE access slows as uptime increases
Message-ID: <20010929202752.A25602@ummagumma>
In-Reply-To: <20010928204612.A911@inxservices.com> <E15nLB7-00027t-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15nLB7-00027t-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Sep 29, 2001 at 03:33:17PM +0100
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.4.9-ac16 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> Second question is what is in your IDE logs. The IDE layer will change
> down speeds when it hits a repeated problem (eg a DMA timeout) so if
> need be will switch back to PIO or to MWDMA.

I have what sounds like a similar problem - assuming it is a problem
with the IDE layer dropping the speed - except mine is with my CD or
DVD drive. They run a lot slower under the 2.4.x kernels than under
2.2.19 (looking at 2-3megs/s under 2.4.x, 5-7megs/s under 2.2.19).

Also when using 2.4.x, the kernel has a habit of disabling DMA and
performance plummets. Yet it is fine with 2.2.19.

Is this a related issue? Is there a fix for this?

Steve Maughan
