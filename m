Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSGIPvA>; Tue, 9 Jul 2002 11:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSGIPu7>; Tue, 9 Jul 2002 11:50:59 -0400
Received: from mnh-1-27.mv.com ([207.22.10.59]:58116 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S315483AbSGIPu6>;
	Tue, 9 Jul 2002 11:50:58 -0400
Message-Id: <200207091655.LAA02540@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-user] Re: user-mode port 0.58-2.4.18-36 
In-Reply-To: Your message of "Tue, 09 Jul 2002 05:16:18 +0200."
             <20020709031618.GC113@elf.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jul 2002 11:55:13 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@ucw.cz said:
> ...and using CAP_SYS_RAWIO... 

... or were you complaining about 'jail' turning off CAP_SYS_RAWIO, rather
than claiming that it is an unplugged hole?

If so, that may be a problem, but I haven't seen anything that cares about
CAP_SYS_RAWIO being off.  That was the simplest way I could find to disable
writing to /dev/kmem.

				Jeff

