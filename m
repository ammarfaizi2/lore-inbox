Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131974AbQL2TYv>; Fri, 29 Dec 2000 14:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132020AbQL2TYk>; Fri, 29 Dec 2000 14:24:40 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41479 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131974AbQL2TYa>; Fri, 29 Dec 2000 14:24:30 -0500
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
To: ppetru@ppetru.net (Petru Paler)
Date: Fri, 29 Dec 2000 18:56:09 +0000 (GMT)
Cc: jakob@unthought.net (Jakob Østergaard),
        andrea@suse.de (Andrea Arcangeli), pegasus@telemach.net (Jure Pecar),
        linux-kernel@vger.kernel.org, thttpd@bomb.acme.com
In-Reply-To: <20001229202120.C573@ppetru.net> from "Petru Paler" at Dec 29, 2000 08:21:20 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14C4hI-0005cK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They do boost performance on SMP (because you can have N (N=3Dnr. of CP=
> Us)
> threads serving data).

Depends on memory bandwidth, caches, locking overhead and a million other
issues. 

> >  on keeping it single-threaded - unless someone can tell me that's a =
> bad
> >  idea)
> 
> Keep it single threaded if you run on UP only...

Theory - SMP needs threading
Practice is generally a little different


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
