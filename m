Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUDGLOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 07:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbUDGLOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 07:14:06 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:45474 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263033AbUDGLOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 07:14:01 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
Date: Wed, 7 Apr 2004 13:21:01 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200404071222.21397.rjwysocki@sisk.pl> <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404071321.01520.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 of April 2004 12:33, Grzegorz Kulewski wrote:
> On Wed, 7 Apr 2004, R. J. Wysocki wrote:
> > Hi,
> >
> > FYI, I've just had a keyboard lockup on a Toshiba laptop (Satellite
> > 1400-103) with the 2.6.5 kernel.
> >
> > It occured when I was typing some text in kmail.  Everything worked just
> > fine except for the keyboard that was locked (dead - even capslock did
> > not work). Fortunately the (USB) mouse worked, so I could reboot the
> > machine "gently" to get my keyboard back in order.
> >
> > I use RH9 with some modifications to support the 2.6.x kernels.  Attached
> > is the .config.
>
> Hi,
>
> Was anything in your logs about that?

No sign of anything related to the keyboard.

> I think that maybe you should disable PREEMPTION.

Well, maybe, but I was using all of the previous 2.6.x _with_ the preepmtion 
enabled and nothing like this happened before.

> Or use different distribution than RH9. They often modify gcc and other
> programs, maybe even X - maybe try to compile your kernel on "vanilla" gcc
> 3.3.3. I can give you a shell on computer with Gentoo and working gcc. Or
> change distribution: Gentoo works ok for me and my friends! :-)

Look, I've been using different variants of the 2.6.x kernels on this very 
machine/distro since early 2.6.0-test and I hadn't seen _anything_ like this 
before 2.6.5-rc2 (then I saw something like this first).  I _really_ don't 
think it's a distribution-related issue.

-- 
Rafael J. Wysocki,
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
