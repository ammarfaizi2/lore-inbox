Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131666AbRDJMlt>; Tue, 10 Apr 2001 08:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131691AbRDJMlL>; Tue, 10 Apr 2001 08:41:11 -0400
Received: from ns.suse.de ([213.95.15.193]:56329 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131666AbRDJMhy>;
	Tue, 10 Apr 2001 08:37:54 -0400
Date: Tue, 10 Apr 2001 14:37:52 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410143752.A16120@gruyere.muc.suse.de>
In-Reply-To: <20010410143216.A15880@gruyere.muc.suse.de> <E14mxNm-0004BT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14mxNm-0004BT-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 10, 2001 at 01:36:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 01:36:27PM +0100, Alan Cox wrote:
> > It's also all interrupts, not only syscalls, and also context switch if you
> > want to be accurate.
> 
> We dont need to be that accurate. Our sample rate is currently so low the
> data is worthless anyway

Just without checking on context switch you would lose the information of per pid
system/user/total that is currently collected completely.

-Andi
