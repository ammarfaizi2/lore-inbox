Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130469AbRADWdg>; Thu, 4 Jan 2001 17:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130667AbRADWd3>; Thu, 4 Jan 2001 17:33:29 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:12736 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S130469AbRADWdU> convert rfc822-to-8bit;
	Thu, 4 Jan 2001 17:33:20 -0500
Date: Thu, 4 Jan 2001 23:33:17 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Igmar Palsenberg <maillist@chello.nl>
cc: Andre Hedrick <andre@linux-ide.org>, Sven Koch <haegar@cut.de>,
        Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <Pine.LNX.4.21.0101042241420.4090-100000@server.serve.me.nl>
Message-ID: <Pine.LNX.4.31.0101042316010.2045-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Jan 2001, Igmar Palsenberg wrote:
> Yeah.. I removed the clipping, and the machine won't boot. It halts after
> PnP init. Any way to use full capacity with the clipping enabled ?

I had the same problem with my 80Gb Maxtor. (Asus P2L97, works with
60Gb but hangs with 80Gb :-/) After clipping the drive with ibmsetmax
(http://www.uwsg.indiana.edu/hypermail/linux/kernel/0012.1/0249.html)
and removing the jumper, unclipping worked fine (kernel is 2.2.18+ide).

Andre: can you add unclipping support to 2.4 too?

Eric

-- 
Eric Lammerts <eric@lammerts.org>  | "It is a mistake to think you can solve
http://www.lammerts.org            |  any major problems just with potatoes"
                                   |                   - Douglas Adams

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
