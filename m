Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130138AbQKALPN>; Wed, 1 Nov 2000 06:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbQKALPD>; Wed, 1 Nov 2000 06:15:03 -0500
Received: from dyna252.cygnus.co.uk ([194.130.39.252]:31729 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S130138AbQKALOw>;
	Wed, 1 Nov 2000 06:14:52 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20001101023010.G13422@athlon.random> 
In-Reply-To: <20001101023010.G13422@athlon.random>  <E13qj56-0003h9-00@pmenage-dt.ensim.com> <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org> <20001031142733.A23516@work.bitmover.com> <39FF49C8.475C2EA7@timpanogas.org> 
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, Larry McVoy <lm@bitmover.com>,
        Paul Menage <pmenage@ensim.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks! 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Nov 2000 11:13:16 +0000
Message-ID: <15012.973077196@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


andrea@suse.de said:
> If that stack switch is your context switch then you share the same VM
> for all tasks. 

> That will never happen in linux,

Isn't that _exactly_ what happens with Linux kernel threads, with lazy mm 
switching?

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
