Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWGMUtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWGMUtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWGMUtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:49:42 -0400
Received: from [83.101.155.109] ([83.101.155.109]:25862 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1030374AbWGMUtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:49:41 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: annoying frequent overcurrent messages.
Date: Thu, 13 Jul 2006 23:50:55 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607132350.55978.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 14:08 +0200, Pavel Machek wrote:
> > > I have a box that's having its dmesg flooded with..
> > > 
> > > hub 1-0:1.0: over-current change on port 1
> > > hub 1-0:1.0: over-current change on port 2
> > > hub 1-0:1.0: over-current change on port 1
> > > hub 1-0:1.0: over-current change on port 2
> > ...
> > 
> > > over and over again..
> > > The thing is, this box doesn't even have any USB devices connected to 
> > > it, so there's absolutely nothing I can do to remedy this.
> > 
> > Well, overcurrent is a potentially dangerous situation.  That's why it 
> > gets reported with dev_err priority.
> 
> Well, I see overcurrents all the time while doing suspend/resume...
> 
> Why is it dangerous? USB should survive plugging something that
> connects +5V and ground. It may turn your machine off, but that should
> be it...?

I don't want to sound alarming here, but I just had a USBFlashStick fried by 
a machine, while in suspend-to-ram running 2.6.17.

I am blaming hw, but does anybody know how I can get my data back?

Thanks!

--
Al

