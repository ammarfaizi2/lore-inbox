Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUE2RSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUE2RSh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 13:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbUE2RSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 13:18:37 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:53383 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265245AbUE2RSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 13:18:36 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Date: Sat, 29 May 2004 12:18:30 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Giuseppe Bilotta <bilotta78@hotpop.com>
References: <20040528154307.142b7abf.akpm@osdl.org> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz>
In-Reply-To: <20040529154443.GA15651@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405291218.30617.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 May 2004 10:44 am, Vojtech Pavlik wrote:
> Module (or kernel cmdline) parameters are not a good way to go, because
> they cannot be changed at runtime. For mouse models, sysfs will be used
> (when I get to implementing sysfs support for serio and input layers),
> and most keyboards don't need any special options, except for scrolling
> keyboards - setkeycode is enough to teach the driver about the special
> scancodes.
> 

I have a patch that sysfsifies all serio drivers but not serio ports yet...
I wanted to get everything in shape before showing it, but if you are
interested I can rediff against the current.

-- 
Dmitry
