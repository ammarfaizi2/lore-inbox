Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271706AbTG2Nvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271712AbTG2Nvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:51:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:39816 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271706AbTG2Nvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:51:36 -0400
Date: Tue, 29 Jul 2003 09:53:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andries.Brouwer@cwi.nl
cc: clepple@ghz.cc, linux-kernel@vger.kernel.org
Subject: Re: Turning off automatic screen clanking
In-Reply-To: <UTC200307291302.h6TD2q310517.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.53.0307290950001.1696@chaos>
References: <UTC200307291302.h6TD2q310517.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 Andries.Brouwer@cwi.nl wrote:

>     Yes. This is f*ing absurb. A default that kills the screen and the
>     requirement to send some @!_$%!@$ sequences to turn it off. This
>     is absolute crap, absolutely positively, with no possible justification
>     whatsoever. If I made an ioctl, it will probably be rejected.........
>
> What language. What about the below (not compiled, not tested)?
>
[SNIPPED...]

I think you need to call poke_blanked_console() after setting the
blanking interval. Also this won't patch on 2.4.20 because the
header file is different. Anyway, I will try it after I take a
work-break.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

