Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268432AbRHJOXK>; Fri, 10 Aug 2001 10:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269317AbRHJOW7>; Fri, 10 Aug 2001 10:22:59 -0400
Received: from dire.bris.ac.uk ([137.222.10.60]:10885 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S268432AbRHJOWw>;
	Fri, 10 Aug 2001 10:22:52 -0400
Date: Fri, 10 Aug 2001 15:22:27 +0100 (BST)
From: Matt <madmatt@bits.bris.ac.uk>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writes to mounted devices containing file-systems.
In-Reply-To: <Pine.SOL.3.96.1010810143222.9790A-100000@draco.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.21.0108101520400.7343-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov mentioned the following:

| Anyway, the kernel could never provide you with ultimate security without
| sacrificing all functionality. Once they get in, they will get root and
| once they have root you have lost, you need to have a system without a
| root user and with nobody having capabilities to do things like load
| modules, etc... There are so many local exploits that you would lose
| for sure. If the attacker cannot write to raw device, he will unmount and
| then write to it or he will load a module to send commands to your HD at
| ATAPI or SCSI level and kill your hd that way...

Couldn't you run something like LIDS? This can be used to lock permissions
down so that root can't unmount filesystems, write to raw devices, etc.

Matt

