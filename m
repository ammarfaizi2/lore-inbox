Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUARM7g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 07:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbUARM7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 07:59:36 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:6613 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261193AbUARM7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 07:59:35 -0500
Date: Sun, 18 Jan 2004 13:59:32 +0100
From: Romain Lievin <romain@rlievin.dyndns.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: True story: "gconfig" removed root folder...
Message-ID: <20040118125932.GA785@rlievin.dyndns.org>
References: <1074177405.3131.10.camel@oebilgen> <Pine.LNX.4.58.0401151558590.27223@serv> <20040115212304.GA25296@rlievin.dyndns.org> <Pine.LNX.4.58.0401152245030.27223@serv> <20040116074341.GA26419@rlievin.dyndns.org> <Pine.LNX.4.58.0401162241440.2530@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0401162241440.2530@serv>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 16, 2004 at 10:44:55PM +0100, Roman Zippel wrote:
> > I mean "destroyed" because my 'root' directory did not exist anymore. When I do
> > a 'ls', I just see a 'root' file with config within.
> > Well, "destroyed" may not be the best word. I can tell that it vanished somewhere.
> > Anyways, I don't have any '*.old' file or directory after that.
> 
> It would be nice if you could try to find out, what exactly happens with
> the directory, the save routine does only a rename...

You're right ! The save routine does on ly a rename. My 'root' directory is simply moved to 'root.old'.

Given that all stuffs are clear now, I'm preparing a patch for this.

> 
> bye, Roman

Thanks, Romain.
-- 
Romain Li�vin (roms):         <roms@tilp.info>
Web site:                     http://tilp.info
"Linux, y'a moins bien mais c'est plus cher !"






