Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261741AbREXMnl>; Thu, 24 May 2001 08:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbREXMna>; Thu, 24 May 2001 08:43:30 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:39436 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261741AbREXMnK>; Thu, 24 May 2001 08:43:10 -0400
Message-ID: <3B0D028F.4B7FBAB0@ntsp.nec.co.jp>
Date: Thu, 24 May 2001 20:46:07 +0800
From: "Adrian V. Bono" <adrianb@ntsp.nec.co.jp>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: patch to put IDE drives in sleep-mode after an halt
In-Reply-To: <003901c0e44d$2de3ea60$093fe33e@host1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"peter k." wrote:

> > I'm not going to comment on the idea, just the implementation.  Eww.
> 
> imho the idea is very good
> i was already wondering why the kernel doesnt spin down the hds when i
> shutdown...
> and its necessary because if you want to move your box the hd heads should
> be parked!
> 
>  - peter k.

Aren't all IDE drives built today auto-parking? Auto-parking became an
inherent feature in voice coil drives (stepper-motor drives weren't
auto-parking), and since all drives are voice coil drives, then they
should auto-park. But i've had problems with some hard drives that were
spinned down (when Win____ was shutdown)..  if i reset the PC (instead
of turning it off), the hard drives wouldn't come back on so i'd have to
do a full shutdown of the machine.
