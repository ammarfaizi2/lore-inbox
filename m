Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbRGPGbh>; Mon, 16 Jul 2001 02:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbRGPGb1>; Mon, 16 Jul 2001 02:31:27 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:2820 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S267215AbRGPGbJ>; Mon, 16 Jul 2001 02:31:09 -0400
Date: Mon, 16 Jul 2001 07:30:01 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Alexander Viro <viro@math.psu.edu>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Adam <adam@eax.com>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate '..' in /lib
In-Reply-To: <Pine.GSO.4.21.0107160128320.26491-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0107160727520.634-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2001, Alexander Viro wrote:

> 	Alex, could you do strace of that? It would clarify the situation.

Unfortunately there's no working version of strace for the sparc32-linux
platform. :o( If anyone knows better, I'd be infinitely grateful - mail me
privately.

As it turns out, the extraneous '..' is actually a file. I did a rm ..*,
which left the original .. directory alone but removed the .. file. Did a
e2fsck on reboot, no problems found.

-- 
Hey, they *are* out to get you, but it's nothing personal.

http://www.tahallah.demon.co.uk

