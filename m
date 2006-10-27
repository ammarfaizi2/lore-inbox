Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752225AbWJ0Odt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbWJ0Odt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 10:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbWJ0Odt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 10:33:49 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:59883 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1752225AbWJ0Ods convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 10:33:48 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend to disk -> resume -> X with DRI extension on R100 chips hangs
Date: Fri, 27 Oct 2006 16:32:28 +0200
User-Agent: KMail/1.9.1
Cc: Radim =?utf-8?q?Lu=C5=BEa?= <xluzar00@stud.fit.vutbr.cz>,
       linux-kernel@vger.kernel.org
References: <453F01CF.2040106@eva.fit.vutbr.cz> <200610252103.47886.rjw@sisk.pl> <20061027112316.GA8095@elf.ucw.cz>
In-Reply-To: <20061027112316.GA8095@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610271632.28928.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 27 October 2006 13:23, Pavel Machek wrote:
> Hi!
> 
> > On Wednesday, 25 October 2006 08:18, Radim Luža wrote:
> > > Good morning
> > > 
> > > I noticed following problem:
> > > After resuming from suspend to disk Xorg with DRI switched on hangs. 
> > > System is not affected by Xorg hang. If I login via SSH I can kill X 
> > > server and start it again - with same result. X server hangs even after 
> > > I suspend from text mode with X not running and with unloaded modules 
> > > radeon and drm and resume then and try to start X server. With DRI 
> > > switched off in xorg.conf X resumes correctly.
> > 
> > Well, I think you'll need to file a bug repart at http://bugzilla.kernel.org
> > (please add rjwysocki@sisk.pl to the Cc list).
> 
> Actually, I'm not sure if this is not an X problem...

Well, me too, but having that on a radar won't hurt.

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
