Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132534AbRDWW5W>; Mon, 23 Apr 2001 18:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132516AbRDWW5N>; Mon, 23 Apr 2001 18:57:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62984 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132511AbRDWW5C>; Mon, 23 Apr 2001 18:57:02 -0400
Subject: Re: compile error 2.4.4pre6: inconsistent operand constraints in an
To: axel@rayfun.org (axel)
Date: Mon, 23 Apr 2001 23:58:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104232306020.4230-100000@neon.rayfun.org> from "axel" at Apr 23, 2001 11:11:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rpIA-0000iK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> after having had trouble with compilation due to old gcc version, i have
> updated to gcc 3.0 and received the following error:

2.4.4pre6 only builds with gcc 2.96. If you apply the __builtin_expect fixes
it builds and runs fine with 2.95. Not tried egcs. The gcc 3.0 asm constraints
one I've yet to see a fix for.
