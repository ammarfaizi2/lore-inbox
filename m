Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282178AbRLGPnw>; Fri, 7 Dec 2001 10:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282644AbRLGPnc>; Fri, 7 Dec 2001 10:43:32 -0500
Received: from scully-a0.index.hu ([217.20.130.10]:12549 "HELO dap.index")
	by vger.kernel.org with SMTP id <S282178AbRLGPnV>;
	Fri, 7 Dec 2001 10:43:21 -0500
Subject: IDE hotswap still broken in 2.4.17pre2...
From: Pallai Roland <dap@omnis.hu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111051847030.719-100000@dap.index>
In-Reply-To: <Pine.LNX.4.33.0111051847030.719-100000@dap.index>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1007590378.24135.2.camel@dap>
Mime-Version: 1.0
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 16:43:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 It's a reproducable bug, same problem reported by
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0111.0/0965.html and
http://www2.real-time.com/pipermail/linux-kernel/2001-November/051937.html. Does it works for anyone?


On Mon, 2001-11-05 at 20:09, PALLAI Roland wrote:
>  When I try to add a new IDE disk to the channel 1 with the command
> "hdparm -R 0x170 0 0 /dev/hda", I've got a kernel oops (and freeze)..
> It's works fine _once_, if there wasn't any detected disk on channel
> before.
> 
> my config:
>  kernel 2.4.9 - 2.4.14pre7 (I've tried many of them)
>  PIIX and VIA motherboards (shows same error)


--
  DaP

