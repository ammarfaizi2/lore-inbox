Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271252AbRHOQCh>; Wed, 15 Aug 2001 12:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271253AbRHOQC1>; Wed, 15 Aug 2001 12:02:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40203 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271252AbRHOQCN>; Wed, 15 Aug 2001 12:02:13 -0400
Subject: Re: 2.4.8 Resource leaks + limits
To: mlist@intergrafix.net (Admin Mailing Lists)
Date: Wed, 15 Aug 2001 17:04:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10108150949160.9584-100000@athena.intergrafix.net> from "Admin Mailing Lists" at Aug 15, 2001 09:51:29 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15X3A9-0003RS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i would think to put global limits in /proc or in a flat text /etc
> and per user limits in something like /etc/passwd or /etc/shadow?
> Is it against any standard to have extra fields in those files?

Take a look at the pam modules, they already handle limit configuration per
user, and I think all the major Linux (and also stuff like Solaris) distros
run PAM based auth
