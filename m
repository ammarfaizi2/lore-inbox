Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263477AbTDXV6A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTDXV6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:58:00 -0400
Received: from [65.244.37.61] ([65.244.37.61]:12892 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S263477AbTDXV57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:57:59 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A9201FD9247@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Daniel Phillips <phillips@arcor.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Flame Linus to a crisp!
Date: Thu, 24 Apr 2003 18:10:01 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Phillips [mailto:phillips@arcor.de]
> > To join a game, you'd have to be able to prove you're running code
> > that is secure all the way from boot to reboot, where everything
> > from network driver to physics engine is known to be compiled from
> > open source that all participants agree is good.
> 
> How would you do that?  What's the protocol?

Public key exchange lets you communicate securely over an insecure link.

> So, the game server and the BIOS have a chat, through the operating
> system (which counts as an insecure link), and the BIOS tells the
> server that it is the correct DRM BIOS, and it loaded a signed kernel.

How does the server _know_ that the BIOS is what it says it is? Again,
what's the protocol?  Saying that they 'have a chat' is bypassing
the hard bits.

If I have the BIOS, any secrets it holds are now knowable to me.
This means that any protocol that relies on a secret in the BIOS is
broken from the start.  So now you need to define a protocol which
does not rely on any secret being known to the BIOS.  What is this
protocol?

> Substitute "broadcaster" for "game server" and you see that the same
? methods ensure that you really have the TV switched on and you are not
> recording the show.

The proposed 'end-to-end' copy protection schemes for entertainment
media etc, rely on proprietary _hardware_.  This is still beatable,
although at a higher cost.  Nor is the problem quite parallel.  The
broadcast problem is 'how do we keep content encrypted till the
last possible moment?' and 'how do we keep the decryption engine tamper
proof reverse engineering proof'.  The first part is easy.  The second
part is not possible in an absolute sense.  It can only be made more 
or less dificult.  Hence the DMCA etc.

> They also ensure you are not recording a screenshot of a politically
> sensitive article about Iraq that was accidentally shown on CNN's web
> site for 10 minutes.  We can't have people recording things like that.

God forbid! ;-)

