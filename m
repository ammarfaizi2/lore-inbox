Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbSLTT2s>; Fri, 20 Dec 2002 14:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbSLTT2s>; Fri, 20 Dec 2002 14:28:48 -0500
Received: from waste.org ([209.173.204.2]:15341 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S265255AbSLTT2r>;
	Fri, 20 Dec 2002 14:28:47 -0500
Date: Fri, 20 Dec 2002 13:36:20 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Robert Love'" <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.52] Use __set_current_state() instead of current-> state = (take 1)
Message-ID: <20021220193620.GE27486@waste.org>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA31@orsmsx116.jf.intel.com> <1040353708.30925.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040353708.30925.20.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 03:08:28AM +0000, Alan Cox wrote:
> In addition you have to treat store ordering/locking carefully due to
> the pentium pro store fencing errata. (Thats why our < PII kernel
> generates lock movb to unlock when in theory the lock isnt needed).

Except the SMP causality test app I wrote got success reports from every
PPro stepping level.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
