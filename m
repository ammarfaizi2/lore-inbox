Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133029AbRDUXO5>; Sat, 21 Apr 2001 19:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133025AbRDUXOr>; Sat, 21 Apr 2001 19:14:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38669 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133039AbRDUXOf>; Sat, 21 Apr 2001 19:14:35 -0400
Subject: Re: 2.4.3+ sound distortion
To: v.p.p.julien@let.rug.nl (Victor Julien)
Date: Sun, 22 Apr 2001 00:15:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01042118044700.01268@victor> from "Victor Julien" at Apr 21, 2001 06:04:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14r6ax-0004Xw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a problem with kernels higher than 2.4.2, the sound distorts when 
> playing a song with xmms while the seti@home client runs. 2.4.2 did not have 
> this problem. I tried 2.4.3, 2.4.4-pre5 and 2.4.3-ac11. They al showed the 
> same problem.

The 2.4.3->2.4.3-ac kernels include workarounds for the VIA chipset corruption
reports. It is possible these have an impact, paticularly if the programs are
making heavy use of X11.

Can you describe the 'distortion' better - clicking, bits repeated ?

