Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbUDXXbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUDXXbc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 19:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUDXXbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 19:31:32 -0400
Received: from main.gmane.org ([80.91.224.249]:19942 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261980AbUDXXb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 19:31:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: standart events for hotkeys?
Date: Sun, 25 Apr 2004 01:31:16 +0200
Message-ID: <MPG.1af516de4881fab2989699@news.gmane.org>
References: <200404200042.24671.cijoml@volny.cz> <200404241900.28907.cijoml@volny.cz> <200404242014.15525.kim@holviala.com> <200404241918.22817.cijoml@volny.cz> <408AB7D6.4060305@hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-76-131.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Meadors wrote:
> Michal Semler wrote:
> 
> > and this is what I mean. We should start project collecting this. As PCI cards 
> > list for example.
> 
> There are as many e-mail keys codes as there are e-mail programs.  And 
> I'm sure there is over lap, where one keyboard's e-mail key, generates 
> the same code as another's web browser key.


See below.

> Also it doesn't really 
> matter what a key is labeled, it could be assigned to anything.

Well, this is a secondary matter.

> What there should be is a program that is configurable, that says when 
> you see this key event, do this.  And such programs do exist, for 
> example the GNOME desktop has ACME.

Recent X versions have keysyms for the multimedia keys, with 
names like XF86AudioPlay, XF86VolumeUp etc. In your keyboard 
setup you can choose an inet module specific for your 
multimedia keyboard (provided it's supported) and the scancodes 
will be converted to the correct keycodes with the attached 
"multimedia" keysyms, which you can then map to the whatever 
action you might want.

> All that has to be done is make sure the kernel passes this codes, and 
> the user space program can gather them.  That seems to be working now.

Or rather not, due to the RAW mode emulation (see also my posts 
on my problems with configuring the multimedia keys of my Dell 
Inspiron 8200 with the 2.6 kernels).

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

