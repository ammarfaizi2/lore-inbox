Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTI0XeI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 19:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbTI0XeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 19:34:08 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:56850 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S262262AbTI0XeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 19:34:06 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Add BTN_TOUCH to Synaptics driver. Update mousedev.
Date: Sat, 27 Sep 2003 22:58:05 +0100
User-Agent: KMail/1.5.4
References: <10645086121286@twilight.ucw.cz> <20030927211838.GC360@elf.ucw.cz> <20030927212116.GA18445@ucw.cz>
In-Reply-To: <20030927212116.GA18445@ucw.cz>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309272258.05132.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 Sep 2003 22:21, Vojtech Pavlik wrote:
> Yes, exactly so. We may have similar problems with differentiation
> elsewhere (touchpad vs 6dof device), so we'll probably need the 'class'
> field.

I don't know if this is relevant, but there are some devices which can work 
in either relative (like a touchpad) or absolute (like a touchscreen) mode.  
For example, using a combination of the kernel and the X drivers, at the 
moment I have my Wacom tablet working in relative mode when I'm using its 
mouse, but absolute mode when I'm using its pen.

I'm wondering whether we don't so much need a device class, as something to 
say whether the device works in absolute or relative mode, and that possibly 
we might have devices where this could be dynamically changed.

M

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
