Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130429AbQKQJhO>; Fri, 17 Nov 2000 04:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130180AbQKQJhF>; Fri, 17 Nov 2000 04:37:05 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:60290 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S130113AbQKQJgy>;
	Fri, 17 Nov 2000 04:36:54 -0500
Message-ID: <20001117170650.A27444@saw.sw.com.sg>
Date: Fri, 17 Nov 2000 17:06:50 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Dennis <dennis@etinc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: intel etherpro100 on 2.2.18p21 vs 2.2.18p17
In-Reply-To: <93BA6BFC5E48D4118A8200508B6BBC4924AB7A@sf1-mail01.hamquist.com> <Pine.LNX.4.10.10011111111390.18876-100000@pmcl.ph.utexas.e du> <5.0.0.25.0.20001114171416.01f7b8f0@mail.etinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <5.0.0.25.0.20001114171416.01f7b8f0@mail.etinc.com>; from "Dennis" on Tue, Nov 14, 2000 at 05:18:25PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 14, 2000 at 05:18:25PM -0500, Dennis wrote:
> There is a flaw in the eepro100 driver that apparently doesnt initialise 
> something properly. The problem is exasperated by the fact that the 

If one want to say it politely, the driver and the hardware sometimes
disagree about the initializing sequence.
Without full documentation, it's hard to say if the driver doesn't follow the
specification or it is a faulty hardware.
For example, I've never observed these problems on hardware except 82559ER.

> eepro100 driver doesn handle the buffer problem properly. We've corrected 
> it by (effectively) resetting the card (by calling close and then open) 
> when the first out of resources event occurs. Its not elegant, but it seems 
> to work.

Best regards
					Andrey V.
					Savochkin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
