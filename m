Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269698AbUJAFan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269698AbUJAFan (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 01:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269701AbUJAFan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 01:30:43 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:52135 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269698AbUJAFal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 01:30:41 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm4
Date: Fri, 1 Oct 2004 00:30:39 -0500
User-Agent: KMail/1.6.2
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <1096586774l.5206l.1l@werewolf.able.es> <20040930170505.6536197c.akpm@osdl.org>
In-Reply-To: <20040930170505.6536197c.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410010030.39826.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 07:05 pm, Andrew Morton wrote:
> > One other question. Isn't /dev/input/mice supposed to be a multiplexor
> > for mice ? I think I remember some time when I could have both a PS2 and
> > a USB mouse connected and X pointer followed both. Now if I boot with the
> > USB mouse plugged, the PS2 one does not work. If I boot with usb unplugged
> > and plug it after boot, both work; usb mouse works fine, and PS2 just
> > jumps half screen each time I move it, and with big delays.
> > 
> 

I bet it's USB legacy emulation topic again. Try loading USB modules first
and then psmouse, should help.

Vojtech, what is the status of USB handoff patches. I have seen several
variants and so far heard only success stories from people using them. Can
we have them in kernel proper?

-- 
Dmitry
