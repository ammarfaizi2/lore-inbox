Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271723AbRHQVoD>; Fri, 17 Aug 2001 17:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271724AbRHQVnx>; Fri, 17 Aug 2001 17:43:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29714 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271723AbRHQVnn>; Fri, 17 Aug 2001 17:43:43 -0400
Subject: Re: 2.4.9 does not compile [PATCH]
To: davem@redhat.com (David S. Miller)
Date: Fri, 17 Aug 2001 22:40:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, aia21@cam.ac.uk, tpepper@vato.org,
        f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 17, 2001 01:57:06 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XrM5-000888-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Its actually basically impossible to do back compat macros
>    with this mess. Your original smin() umin() proposal was _much_ saner.
> 
> I don't see how you can logically say this.

Because it would have been trivial to provide back compatibility macros to
provide sint_min/sint_max on 2.2. Now all I can do is make -ac use sint_min
sint_max and friends (or typed_min to be exact) and make 2.2 and -ac 
compatible

> My sint_min() etc. version broke things just
> as equally because it had:

Nothing like as badly.

Alan
