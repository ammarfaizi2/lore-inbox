Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbRFVNdo>; Fri, 22 Jun 2001 09:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265411AbRFVNde>; Fri, 22 Jun 2001 09:33:34 -0400
Received: from customers.imt.ru ([212.16.0.33]:36623 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id <S265409AbRFVNdX>;
	Fri, 22 Jun 2001 09:33:23 -0400
Message-ID: <20010622093158.B2448@saw.sw.com.sg>
Date: Fri, 22 Jun 2001 09:31:58 -0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: dwilson@technologist.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100: wait_for_cmd_done timeout
In-Reply-To: <20010620163134.A22173@technolunatic.com> <20010620195134.A6877@saw.sw.com.sg> <20010620170202.B22565@technolunatic.com> <20010621183603.A28081@technolunatic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010621183603.A28081@technolunatic.com>; from "Dionysius Wilson Almeida" on Thu, Jun 21, 2001 at 06:36:03PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 06:36:03PM -0700, Dionysius Wilson Almeida wrote:
> I tried inserting a udelay(1) and increasing the count ..but
> the same behaviour.  
> 
> any clues ? btw, i've been able to compile the redhat 7.1 intel e100
> driver and it works fine for my card.

Your problem is different from anyone else's, as I explained.
You see "netdev watchdog" message first.
It means that the card just stopped to transmit packets.
All other messages printed after that, including wait_for_cmd_done timeout,
are irrelevant to this problem.  Your card just doesn't transmit.

Please send me a complete log of what the kernel prints, since powering up
the computer.

	Andrey
