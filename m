Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269032AbTBWXvm>; Sun, 23 Feb 2003 18:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269033AbTBWXvm>; Sun, 23 Feb 2003 18:51:42 -0500
Received: from maild.telia.com ([194.22.190.101]:61642 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S269032AbTBWXvl>;
	Sun, 23 Feb 2003 18:51:41 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Date: Mon, 24 Feb 2003 01:01:42 +0100 (CET)
Message-Id: <20030224.010142.81964578.cfmd@swipnet.se>
To: alan@lxorguk.ukuu.org.uk
Cc: albert@users.sourceforge.net, developer_linux@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: Question about Linux signal handling
From: Magnus Danielson <cfmd@swipnet.se>
In-Reply-To: <1046043810.2092.0.camel@irongate.swansea.linux.org.uk>
References: <1046039341.32116.34.camel@cube>
	<1046043810.2092.0.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 3.1 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Question about Linux signal handling
Date: 23 Feb 2003 23:43:31 +0000

> On Sun, 2003-02-23 at 22:29, Albert Cahalan wrote:
> > Yes. This is the behavior of all SysV UNIX systems
> > and Linux kernels. Unfortunately, BSD got it wrong.
> 
> Firstly BSD didn't get it wrong, things merely diverged
> historically after V7 unix.

The V7 signals where not reliable and there where not neatly blockable.
Naturally people invented incompatible solutions to come around it, just as
you would expect.

Cheers,
Magnus - porting teaches you stuff you didn't want to know about
