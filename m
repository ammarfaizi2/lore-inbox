Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVBOCkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVBOCkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 21:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVBOCkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 21:40:39 -0500
Received: from mail43-s.fg.online.no ([148.122.161.43]:56202 "EHLO
	mail43-s.fg.online.no") by vger.kernel.org with ESMTP
	id S261603AbVBOCka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 21:40:30 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech MX1000 Horizontal Scrolling
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
	<87zmylaenr.fsf@quasar.esben-stien.name>
	<20050204195410.GA5279@ucw.cz>
From: Esben Stien <b0ef@esben-stien.name>
X-Home-Page: http://www.esben-stien.name
Date: Tue, 15 Feb 2005 03:40:07 +0100
In-Reply-To: <20050204195410.GA5279@ucw.cz> (Vojtech Pavlik's message of
 "Fri, 4 Feb 2005 20:54:10 +0100")
Message-ID: <873bvyfsvs.fsf@quasar.esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> Please try if 2.6.11-rc3 is any better.

Yes, nice, the error is gone and I've verified with blender that the
horizontal scroll works as it should;).

Firefox gives me something strange, but the kernel issue is resolved.

I'll explain what firefox gives me, in case you're interested, but
I'll take this issue over to the firefox mailinglist.

I'm using xbindkeys to set up what the mouse is supposed to do:

"xvkbd -xsendevent -text "\[Left]""
  b:11

"xvkbd -xsendevent -text "\[Right]""
  b:12

#11 = HORIZONTAL LEFT
#12 = HORIZONTAL RIGHT

With this config, it is supposed to scroll in the horizontal direction
when keys 11/12 are pressed/moved/tilted.

Now, in firefox, I tilt the wheel in the right direction. It moves one
cm to the right, but then proceeds to move up and it continues to do
so until it reaches the top of the page or I release the button. 

It is supposed to just move right, of course, as long as the tilt
wheel is not released and there is more data in the right direction. 

-- 
Esben Stien is b0ef@esben-stien.name
http://www.esben-stien.name
irc://irc.esben-stien.name/%23contact
[sip|iax]:b0ef@esben-stien.name
