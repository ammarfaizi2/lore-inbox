Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264474AbTDXVQM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbTDXVQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:16:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:18824 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264474AbTDXVQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:16:06 -0400
Date: Thu, 24 Apr 2003 22:28:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Downing, Thomas" <Thomas.Downing@ipc.com>
Cc: Daniel Phillips <phillips@arcor.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424212811.GH30082@mail.jlokier.co.uk>
References: <170EBA504C3AD511A3FE00508BB89A9201FD91E8@exnanycmbx4.ipc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170EBA504C3AD511A3FE00508BB89A9201FD91E8@exnanycmbx4.ipc.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Downing, Thomas wrote:
> From: Daniel Phillips [mailto:phillips@arcor.de]
> > To join a game, you'd have to be able to prove you're running code
> > that is secure all the way from boot to reboot, where everything
> > from network driver to physics engine is known to be compiled from
> > open source that all participants agree is good.
> 
> How would you do that?  What's the protocol?

Public key exchange lets you communicate securely over an insecure link.

So, the game server and the BIOS have a chat, through the operating
system (which counts as an insecure link), and the BIOS tells the
server that it is the correct DRM BIOS, and it loaded a signed kernel.

So the server can trust the kernel.  It chats with the kernel, which
confirms that it is running a signed physics engine, a signed 3rd party
network driver, a signed video driver, the video is connected to a
signed monitor, the input is connected to a signed joystick, and that
conversations on TCP port XXX are connected to the physics engine.

This is how a game server can verify it is working with a known game
client and the client is connected to a known type of monitor and
input device.  I.e. it can verify there is no electronic frame grabber
using the video signals and driving an AI assist through the input
device.

Additionally, the trusted kernel and trusted video driver can prove
that they are encrypting the video link, so that it is imposible to
record the gameplay using standard video recording hardware.

   ---

Substitute "broadcaster" for "game server" and you see that the same
methods ensure that you really have the TV switched on and you are not
recording the show.

They also ensure you are not recording a screenshot of a politically
sensitive article about Iraq that was accidentally shown on CNN's web
site for 10 minutes.  We can't have people recording things like that.

Also that day, that same article doesn't load from Al-Jazeera or
anywhere else, on the PC you bought from the only affordable store in
town.  Is the net flaky today, or is somebody remote-controlling your
PC to control your "browsing experience"?

-- Jamie
