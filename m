Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTDXCiC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 22:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263549AbTDXCiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 22:38:02 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:9190 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263540AbTDXCiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 22:38:01 -0400
Date: Wed, 23 Apr 2003 22:34:34 -0400
From: Ben Collins <bcollins@debian.org>
To: Pat Suwalski <pat@suwalski.net>
Cc: Werner Almesberger <wa@almesberger.net>, Pavel Machek <pavel@ucw.cz>,
       Matthias Schniedermeyer <ms@citd.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424023434.GF354@phunnypharm.org>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423172120.GA12497@citd.de> <3EA6947D.9080106@suwalski.net> <20030423221749.GA9187@elf.ucw.cz> <3EA71533.4090008@suwalski.net> <20030423225520.GA32577@atrey.karlin.mff.cuni.cz> <20030423231920.D1425@almesberger.net> <3EA74BF1.2090700@suwalski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA74BF1.2090700@suwalski.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 10:29:05PM -0400, Pat Suwalski wrote:
> Werner Almesberger wrote:
> >So you're claiming that users will find it more difficult to add
> >one line to rc.local than upgrading their kernel ?
> 
> No.
> 
> I believe he is saying that ever since 1984 and the Mac Plus, it has 
> been expected that sound works right away without adding any lines anywhere.
> 
> I have not seen a computer in the last year and a half that has not had 
> either onboard sound or a card. It is very standard hardware these days. 
> Therefore, your soundcard should work just like your keyboard does. You 
> do not have to add any lines to any rc script to get the keyboard 
> working, do you? Sound should not have to be any different, in an ideal 
> world.

Sound may be a standard feature, but it does not get driven by a
standard interface like PS2 or HID keyboards do. It's also not as
straight forward as "sound or no sound". There's many different levels
of sound hardware, from the 2-channel basic stereo, to the 6-way Dolby
Digital 5.1.

Whether or not a line is needed in an rc script is really a shortcoming
of userspace, IMO. It's the responsibility of userspace to setup the
user's environment in the most friendly way.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
