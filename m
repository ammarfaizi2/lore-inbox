Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264499AbRFOTpg>; Fri, 15 Jun 2001 15:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264498AbRFOTpZ>; Fri, 15 Jun 2001 15:45:25 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:8210 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S264497AbRFOTpU>;
	Fri, 15 Jun 2001 15:45:20 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Fri, 15 Jun 2001 21:43:31 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [patch] nonblinking VGA block cursor
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <5E9F5DB4FCA@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jun 01 at 21:34, Daniel Phillips wrote:
> On Friday 15 June 2001 21:21, Albert D. Cahalan wrote:
> > Non-blinking cursors are just wrong. You need to patch your brain.
> > You really fucked up, because now apps can't restore your cursor
> > to proper behavior as defined by IBM.
> 
> Just one question Albert: why doesn't my mouse cursor blink? ;-)

Because of you can move mouse cursor - moving mouse usually does not
have serious side effect. Normal cursor cannot be moved without
sideeffects, so you cannot find it so easy.

If you want, just plug matrox into your laptop and use matroxfb. It
restarts cursor blinking cycle on each character printed to screen,
so while you are typing, you still see cursor, but if you stop typing,
cursor starts blinking...

Just my 0.02Kc.
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz

[matroxfb has also noblink option because HPA wanted it. But it is
another story]
