Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316799AbSFUW2t>; Fri, 21 Jun 2002 18:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSFUW2s>; Fri, 21 Jun 2002 18:28:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17673 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316799AbSFUW2s>; Fri, 21 Jun 2002 18:28:48 -0400
Subject: Re: .i2c-old.ver.d: No such file or directory
To: jfbeam@bluetronic.net (Ricky Beam)
Date: Fri, 21 Jun 2002 23:50:50 +0100 (BST)
Cc: kai@tp1.ruhr-uni-bochum.de (Kai Germaschewski),
       tobyink@goddamn.co.uk (Toby Inkster), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0206191345560.10816-100000@sweetums.bluetronic.net> from "Ricky Beam" at Jun 19, 2002 02:01:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17LXEw-0001oM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >The problem is that the i2c code is currently broken, it includes
> >linux/i2c-old.h which doesn't exist. You'll see the error much more
> >clearly if you run "make KBUILD_VERBOSE= dep" ;)
> 
> Yes.  This is due to the "New and Improved Build System (tm)". (It's not
> really new -- kbuild has been around as an option for a long time.  And

No its because a file was deleted to persuade people to stop using stuff
that was going away for 2.4 and finally did
