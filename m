Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbRFSWXJ>; Tue, 19 Jun 2001 18:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264816AbRFSWW7>; Tue, 19 Jun 2001 18:22:59 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:19212 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264815AbRFSWWy>;
	Tue, 19 Jun 2001 18:22:54 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac15 -- Unresolved symbols "gameport_register_port" 
In-Reply-To: Your message of "Tue, 19 Jun 2001 19:33:26 +0200."
             <20010619193326.A295@suse.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Jun 2001 08:22:47 +1000
Message-ID: <24417.992989367@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001 19:33:26 +0200, 
Vojtech Pavlik <vojtech@suse.cz> wrote:
>On Wed, Jun 20, 2001 at 12:43:02AM +1000, Keith Owens wrote:
>> drivers/char/Makefile says
>> subdir-$(CONFIG_INPUT) += joystick
>
>Ouch. Forgot about this one. I guess it'd be better to fix this, because
>the gameport code really is independent on input.

The number of gameport devices is large enough to justify their own
subdirectory, drivers/char/gameport instead of being lumped in with the
joysticks.  What do you think?

