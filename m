Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbRFZPir>; Tue, 26 Jun 2001 11:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264999AbRFZPi2>; Tue, 26 Jun 2001 11:38:28 -0400
Received: from m355-mp1-cvx1c.col.ntl.com ([213.104.77.99]:45956 "EHLO
	[213.104.77.99]") by vger.kernel.org with ESMTP id <S264994AbRFZPiP>;
	Tue, 26 Jun 2001 11:38:15 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: VM tuning through fault trace gathering [with actual code]
In-Reply-To: <Pine.LNX.4.21.0106261031150.850-100000@freak.distro.conectiva>
From: John Fremlin <vii@users.sourceforge.net>
Date: 26 Jun 2001 16:38:07 +0100
In-Reply-To: <Pine.LNX.4.21.0106261031150.850-100000@freak.distro.conectiva> (Marcelo Tosatti's message of "Tue, 26 Jun 2001 10:52:16 -0300 (BRT)")
Message-ID: <m2vgljb6ao.fsf@boreas.yi.org.>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> ####################################################################
> Event     	          Time                   PID     Length Description
> ####################################################################
> 
> Trap entry              991,299,585,597,016     678     12      TRAP: page fault; EIP : 0x40067785

That looks like just the generic interrupt handling. It does not do
what I want to do, i.e. record some more info about the fault saying
where it comes from.

-- 

	http://ape.n3.net
