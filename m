Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264588AbSIVWqJ>; Sun, 22 Sep 2002 18:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264590AbSIVWqJ>; Sun, 22 Sep 2002 18:46:09 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:13441 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264588AbSIVWqH>; Sun, 22 Sep 2002 18:46:07 -0400
Date: Sun, 22 Sep 2002 17:51:12 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] linux kernel conf 0.6
In-Reply-To: <3D8E4720.2050700@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0209221744150.11808-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Sep 2002, Jeff Garzik wrote:

> One cosmetic thing I mentioned to Roman, Config.new needs to be changed 
> to something better, like conf.in or build.conf or somesuch.

I agree. (But I'm not particularly good at coming up with names ;) 
build.conf is maybe not too bad considering that there may be a day where 
it is extended to support "<driver>.conf" as well.


One other thing I wanted to mention but forgot was that lkc now
does a quiet "make oldconfig" when .config changed or does not exist, 
which is changed behavior.

I intentionally only printed a message and errored out in this case, and I 
think that's more useful, particularly for people doing

make all 2>&1 > make.log

which now may take forever waiting for input.

--Kai


