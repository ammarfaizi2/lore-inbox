Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTDYMLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 08:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTDYMLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 08:11:42 -0400
Received: from [65.244.37.61] ([65.244.37.61]:30185 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S263894AbTDYMLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 08:11:40 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A9201FD92B0@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Daniel Phillips <phillips@arcor.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Flame Linus to a crisp!
Date: Fri, 25 Apr 2003 08:23:48 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
Jamie Lokier [mailto:jamie@shareable.org]

>Downing, Thomas wrote:
>> How does the server _know_ that the BIOS is what it says it is? Again,
>> what's the protocol?  Saying that they 'have a chat' is bypassing
>> the hard bits.
>> 
>> If I have the BIOS, any secrets it holds are now knowable to me.
>> This means that any protocol that relies on a secret in the BIOS is
>> broken from the start.  So now you need to define a protocol which
>> does not rely on any secret being known to the BIOS.  What is this
> protocol?
>
>What makes you think you can read the BIOS?
If it is a BIOS in the PC-compatible sense, of course I can.
>
>> The proposed 'end-to-end' copy protection schemes for entertainment
>> media etc, rely on proprietary _hardware_.
>
>Yes, that's the severe version of DRM that we're talking about, for
>the game server scenario.
I though that this was in reference to a way to solve Quake etc.
cheating in the current hardware environment.  I you pull in 
extra hardware, the equation changes.
>
>> This is still beatable, although at a higher cost.  Nor is the
>> problem quite parallel.  The broadcast problem is 'how do we keep
>> content encrypted till the last possible moment?' and 'how do we
>> keep the decryption engine tamper proof reverse engineering proof'.
>> The first part is easy.  The second part is not possible in an
>> absolute sense.  It can only be made more or less dificult.  Hence
>> the DMCA etc.
>
>We don't know for sure that it's not possible to make something
>reverse engineering proof.  Although all current CPUs require code to
>be decrypted at some point, there may be modules of computation that
>don't require that, so there would be no way to extract the secret key
>or decryption process in a useful way even when you can see every
>electronic signal in a device.  The jury is out on it, despite what
>slashdotters believe.
>
>-- Jamie

Depends on who sits on the jury.  With few if any exceptions, the top
people in the security field would agree with what I said.  That's not
because I'm brilliant, it's because I'm just parrotting back what
they have said.

As is often said, security is all shades of grey.  It may well be
possible to make a device that is so hard to reverse engineer and so
hard to hack, that it offers protection that lasts as long as the
effective market life of the thing it is protecting.  At that point
it is good enough.  Now you have a foundation on which to base
the required protocol.  You are now done from the theoretic side,
and this debate comes to an end; you have your Quake-cheat blocker.

But if you go on to consider the practical side, even now you have
only solved the easy part: the tough part is correctly implementing
the entire 'soft' chain from this device to the corresponding device
on the server.  Now _that's_ not easy.
