Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbTAZRbg>; Sun, 26 Jan 2003 12:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbTAZRbg>; Sun, 26 Jan 2003 12:31:36 -0500
Received: from [66.70.28.20] ([66.70.28.20]:61201 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266852AbTAZRbe>; Sun, 26 Jan 2003 12:31:34 -0500
Date: Sun, 26 Jan 2003 18:40:41 +0100
From: DervishD <raul@pleyades.net>
To: sundara raman <sundararamand@yahoo.com>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: doubts in INIT - while system booting up
Message-ID: <20030126174041.GG54@DervishD>
References: <20030126170034.30209.qmail@web20507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030126170034.30209.qmail@web20507.mail.yahoo.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Sundara :)

> 	 INIT: Id "x" respawing too fast: disabled for 5 minutes

    This has nothing to do with the kernel. Read the manual for your
sysvinit. There is the explanation of the problem and the posible
solutions.

    FYI, your problem is a process spawned by your 'init' (check
/etc/inittab) dieing as soon as it is created. In order to avoid this
exec-die cycle, the respawning is stopped during 5 minutes. Read the
manual, anyway ;))

    Raúl
