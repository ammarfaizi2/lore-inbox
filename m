Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRAGVUM>; Sun, 7 Jan 2001 16:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129977AbRAGVUC>; Sun, 7 Jan 2001 16:20:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52496 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129669AbRAGVTq>; Sun, 7 Jan 2001 16:19:46 -0500
Subject: Re: Patch (repost): cramfs memory corruption fix
To: riel@conectiva.com.br (Rik van Riel)
Date: Sun, 7 Jan 2001 21:20:07 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        adam@yggdrasil.com (Adam J. Richter), parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101071910200.21675-100000@duckman.distro.conectiva> from "Rik van Riel" at Jan 07, 2001 07:11:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FNEZ-0003LV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sounds like a job for ... <drum roll> ... tmpfs!!
> 
> (and yes, I share your opinion that ramfs is nice _because_
> it's an easy example for filesystem code teaching)

The resource tracking ramfs isnt that much uglier to be honest. One that went
off using backing store would be, but ramfs with limits simply ensures that

dd if=/dev/zero of=/mnt/ram/foo

doesnt crash your box
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
