Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265076AbSJRLjG>; Fri, 18 Oct 2002 07:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265079AbSJRLjG>; Fri, 18 Oct 2002 07:39:06 -0400
Received: from 62-190-217-213.pdu.pipex.net ([62.190.217.213]:11526 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S265076AbSJRLjF>; Fri, 18 Oct 2002 07:39:05 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210181154.g9IBsG2A001135@darkstar.example.net>
Subject: Re: 2.5 and lowmemory boxens
To: _deepfire@mail.ru
Date: Fri, 18 Oct 2002 12:54:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E182V29-000Pfa-00@f15.mail.ru> from "Samium Gromoff" at Oct 18, 2002 03:11:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    first: i`ve successfully ran 2.5.43 on a 386sx20/4M ram notebook.

Cool, I thought my 486sx20/4M was a good achievement :-)

>  the one problem was the ppp over serial not working, but i suspect
>  that it just needs to be recompiled with 2.5 headers (am i right?).

I have found that 16450-based serial ports are unreliable under
2.5.x.  Enabling interrupt un-masking didn't help, and I suspect that
it is just the generally more bloated kernel making the cache, (or in
the case of a 386, the pre-fetch unit :-) ), less efficient, and
causing data to be lost.

>  the other was, well, the fact that ultra-stripped 2.5.43
>  still used 200k more memory than 2.4.19, and thats despite it was
>  compiled with -Os instead of -O2.
>  actually it was 2000k free with 2.4 vs 1800k  free with 2.5

Yes, I've noticed the same thing during my experiments with low-memory boxes.

>  i know Rik had plans of some ultra bloody embedded/lowmem
>  changes for such cases. i`d like to hear about things in the area :)

I am also very interested in it.

John.
