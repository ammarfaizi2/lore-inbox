Return-Path: <linux-kernel-owner+w=401wt.eu-S932765AbWLNPJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbWLNPJh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWLNPJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:09:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59526 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932765AbWLNPJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:09:36 -0500
Message-ID: <4581692E.20303@festi.info>
Date: Thu, 14 Dec 2006 16:09:34 +0100
From: Florian Festi <florian@festi.info>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Meaning of keycodes unclear
References: <45753BB1.6030102@festi.info>
In-Reply-To: <45753BB1.6030102@festi.info>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Festi wrote:
> I am looking for the meaning of the following key codes as #defined in 
> include/linux/input.h. I need to know what hardware produces the keycode 
> and what happens/should happen when the corresponding key is pressed.

Thanks for all you comments! They helped a lot.
The meaning for some keycodes is still missing, though:

* KEY_ARCHIVE, KEY_FILE, KEY_DIRECTORY - What's the difference here?
* KEY_DIGITS
* KEY_ISO - somehow related to KEY_KATAKANAHIRAGANA ??? (mapped to same 
scancode in rawmode emulation)
* KEY_MODE
* KEY_QUESTION - what's the difference to KEY_INFO and KEY_SEARCH?
* KEY_SCREEN - switch between 4:3 and 16:9 ???

> I am currently trying to make all special keys just work by fixing the 
> whole keyboard/input stack from the kernel up to the desktop 
> environments. On part of this effort is to complete the mappings applied 
> to the keys during their way up.

Thanks again

      Florian Festi



