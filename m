Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269011AbTBWWd0>; Sun, 23 Feb 2003 17:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269013AbTBWWd0>; Sun, 23 Feb 2003 17:33:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28544
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269011AbTBWWd0>; Sun, 23 Feb 2003 17:33:26 -0500
Subject: Re: Question about Linux signal handling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: developer_linux@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1046039341.32116.34.camel@cube>
References: <1046039341.32116.34.camel@cube>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046043810.2092.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 23 Feb 2003 23:43:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-23 at 22:29, Albert Cahalan wrote:
> Yes. This is the behavior of all SysV UNIX systems
> and Linux kernels. Unfortunately, BSD got it wrong.

Firstly BSD didn't get it wrong, things merely diverged
historically after V7 unix.

> Worse, the glibc developers saw fit to ignore both
> UNIX history and Linus. They implemented BSD behavior
> by making signal() use the sigaction system call

Also wrong. If you read the gcc documentation you can
select favouring BSD or SYS5 behaviour at compile time

glibc has the best of both worlds

