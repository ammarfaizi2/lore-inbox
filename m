Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264066AbRFTXxs>; Wed, 20 Jun 2001 19:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264072AbRFTXxi>; Wed, 20 Jun 2001 19:53:38 -0400
Received: from customers.imt.ru ([212.16.0.33]:20791 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id <S264066AbRFTXx0>;
	Wed, 20 Jun 2001 19:53:26 -0400
Message-ID: <20010620195134.A6877@saw.sw.com.sg>
Date: Wed, 20 Jun 2001 19:51:34 -0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Dionysius Wilson Almeida <dwilson@technolunatic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: eepro100: wait_for_cmd_done timeout
In-Reply-To: <20010620163134.A22173@technolunatic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010620163134.A22173@technolunatic.com>; from "Dionysius Wilson Almeida" on Wed, Jun 20, 2001 at 04:31:34PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What was the first error message from the driver?
NETDEV WATCHDOG report went before wait_for_cmd_done timeout and is more
important.  I wonder if you had some other messages before the watchdog one.

	Andrey

On Wed, Jun 20, 2001 at 04:31:34PM -0700, Dionysius Wilson Almeida wrote:
> And this is the log when the card hangs :
> =========================================
> Jun 20 16:10:18 debianlap kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Jun 20 16:10:18 debianlap kernel: eth0: Transmit timed out: status 0050  0c80 at 314/342 command 000c0000.
> Jun 20 16:10:18 debianlap kernel: eth0: Tx ring dump,  Tx queue 342 / 314:
> Jun 20 16:14:07 debianlap kernel: eepro100: wait_for_cmd_done timeout!
> Jun 20 16:14:38 debianlap last message repeated 5 times
