Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268092AbUIPT1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268092AbUIPT1d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 15:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268138AbUIPT1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 15:27:33 -0400
Received: from colin2.muc.de ([193.149.48.15]:24072 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268092AbUIPT1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 15:27:32 -0400
Date: 16 Sep 2004 21:27:30 +0200
Date: Thu, 16 Sep 2004 21:27:30 +0200
From: Andi Kleen <ak@muc.de>
To: Albert Cahalan <albert@users.sf.net>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: get_current is __pure__, maybe __const__ even
Message-ID: <20040916192730.GA68479@muc.de>
References: <2ER4z-46B-17@gated-at.bofh.it> <m3llfaya29.fsf@averell.firstfloor.org> <1095344098.3866.1396.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095344098.3866.1396.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I count 8 items passed in or out of the asm.
> I count 11 clobbers. You don't have 19 registers.

Read it again. Many of the input arguments are not
registers, but "i" or "m" 

> I recall seeing i386 compilers complain about
> clobbered inputs. I guess the x86-64 gcc needs
> to have this warning added?

All gcc ports use the same code for this, no difference.

-Andi
