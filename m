Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262819AbRE3Vvj>; Wed, 30 May 2001 17:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262822AbRE3Vv3>; Wed, 30 May 2001 17:51:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5641 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262821AbRE3VvX>; Wed, 30 May 2001 17:51:23 -0400
Subject: Re: ln -s broken on 2.4.5
To: Marcus.Meissner@caldera.de (Marcus Meissner)
Date: Wed, 30 May 2001 22:49:18 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mm@ns.caldera.de (Marcus Meissner),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010530233005.A27497@caldera.de> from "Marcus Meissner" at May 30, 2001 11:30:05 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155DqA-0006g7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is only there if you specify a directory for the linked to
> component.
> 
> [marcus@wine /tmp]$ strace -f ln -s fupp/berk xxx
> execve("/bin/ln", ["ln", "-s", "fupp/berk", "xxx"], [/* 39 vars */]) = 0
> ... ld stuff ... locale stuff ... 

bash-2.04$ ln -s foo/frob eep
bash-2.04$ ls -l eep
lrwxrwxrwx    1 alan     users           8 May 30 22:19 eep -> foo/frob
