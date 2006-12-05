Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967495AbWLELQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967495AbWLELQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968113AbWLELP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:15:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52199 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S967495AbWLELP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:15:58 -0500
Date: Tue, 5 Dec 2006 12:15:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Florian Festi <florian@festi.info>, vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: Meaning of keycodes unclear
Message-ID: <20061205111541.GB6987@elf.ucw.cz>
References: <45753BB1.6030102@festi.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45753BB1.6030102@festi.info>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-12-05 10:28:17, Florian Festi wrote:
> I am looking for the meaning of the following key codes as #defined in 
> include/linux/input.h. I need to know what hardware produces the keycode 
> and what happens/should happen when the corresponding key is pressed.
> 
> KEY_AB
> KEY_ANGLE
> KEY_ARCHIVE
> KEY_CONNECT
> KEY_DIGITS

> KEY_MACRO

Macro key was present on some old keyboards. It allowed macro definitions.

> KEY_ISO
> KEY_LIST
> KEY_POWER2
> KEY_QUESTION

> KEY_TEEN      # 1- ???
> KEY_TWEN      # 2- ???

Yep. Very common on remote controls.

> KEY_RED, KEY_GREEN, KEY_YELLOW, KEY_BLUE  # Video text navigation?

Yes.

> I am currently trying to make all special keys just work by fixing the 
> whole keyboard/input stack from the kernel up to the desktop 
> environments. On part of this effort is to complete the mappings applied 
> to the keys during their way up.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
