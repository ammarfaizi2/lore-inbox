Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSGFV5U>; Sat, 6 Jul 2002 17:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSGFV5T>; Sat, 6 Jul 2002 17:57:19 -0400
Received: from mnh-1-10.mv.com ([207.22.10.42]:11269 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S312498AbSGFV5S>;
	Sat, 6 Jul 2002 17:57:18 -0400
Message-Id: <200207062303.SAA02760@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-user] Re: user-mode port 0.58-2.4.18-36 
In-Reply-To: Your message of "Sat, 06 Jul 2002 03:16:45 +0200."
             <20020706011643.GD112@elf.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Jul 2002 18:03:00 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@ucw.cz said:
> So... what prevents uml root from inserting rogue module (perhaps
> using /dev/kmem) and escape the jail? 

That's prevented by the admin taking basic precautions and turning on 'jail',
which refuses to run if module support is present and which also disables
writing to /dev/kmem.

				Jeff

