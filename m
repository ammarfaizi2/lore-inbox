Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131262AbRBQUbQ>; Sat, 17 Feb 2001 15:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131420AbRBQUbG>; Sat, 17 Feb 2001 15:31:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24840 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131262AbRBQUbA>; Sat, 17 Feb 2001 15:31:00 -0500
Subject: Re: 2.4.1ac17 hang on mounting loopback fs
To: neldredge@hmc.edu (Nate Eldredge)
Date: Sat, 17 Feb 2001 20:31:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14990.18933.849551.526672@mercury.st.hmc.edu> from "Nate Eldredge" at Feb 17, 2001 01:52:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UE0r-00071Q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> # mount -t ext2 -o loop /spare/i486-linuxaout.img /spare/mnt
> loop: enabling 8 loop devices

Loop does not currently work in 2.4. It might partly work by luck but thats it.
This will change as and when the new loop patches go in. Until then if you need
loop use 2.2

