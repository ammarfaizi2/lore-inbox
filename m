Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbVKBOob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbVKBOob (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbVKBOob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:44:31 -0500
Received: from tim.rpsys.net ([194.106.48.114]:26271 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965059AbVKBOoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:44:30 -0500
Subject: Re: Make spitz compile again
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051102135253.GK30194@elf.ucw.cz>
References: <20051031134255.GA8093@elf.ucw.cz>
	 <1130773530.8353.39.camel@localhost.localdomain>
	 <20051102125107.GA12891@elf.ucw.cz>
	 <1130939279.8523.10.camel@localhost.localdomain>
	 <20051102135253.GK30194@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 14:44:07 +0000
Message-Id: <1130942647.8523.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 14:52 +0100, Pavel Machek wrote:
> Hi!
> 
> > On Wed, 2005-11-02 at 13:51 +0100, Pavel Machek wrote:
> > > Did you see any problems with touchscreen? I see "ts" registered,
> > > interrupts coming, but opie does not see any clicks :-(.
> > 
> > Update to udev 071 ;-)
> 
> Is there some other workaround? I'm not able to do that on spitz --
> you know my bitbake capabilities :-(.

Create /dev/input/ and add event0 and event1 nodes. You'll have to hack
the init scripts to do this and fight off udev.

or

Download and copy this to the device:
http://www.rpsys.net/openzaurus/temp/udev_071-r5_armv5te.ipk

and ipkg install udev_071-r5_armv5te.ipk

I'm not sure these kind of things should be going to LKML in future
though...

Richard

