Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270401AbRIBXa2>; Sun, 2 Sep 2001 19:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270438AbRIBXaS>; Sun, 2 Sep 2001 19:30:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:525 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270401AbRIBXaJ>; Sun, 2 Sep 2001 19:30:09 -0400
Subject: Re: [parisc-linux] Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs
To: davem@redhat.com (David S. Miller)
Date: Mon, 3 Sep 2001 00:29:48 +0100 (BST)
Cc: Richard.Zidlicky@stud.informatik.uni-erlangen.de, thunder7@xs4all.nl,
        parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010902.160859.104033892.davem@redhat.com> from "David S. Miller" at Sep 02, 2001 04:08:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dggW-0000bJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It will trap and run very slowly, but it wont' OOPS and
> it will give correct results.
> 
> This is actually required behavior, I don't know why parisc
> is acting differently.

Several of the platforms only have trap fixups for a small subset of operations
that can legitimately occur on things like networking headers. It makes the
recovery code a lot smaller and cleaner.

Alan
