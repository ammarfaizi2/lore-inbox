Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264446AbUKBJcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbUKBJcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 04:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264587AbUKBJcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:32:11 -0500
Received: from sd291.sivit.org ([194.146.225.122]:58324 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S263625AbUKBJb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:31:56 -0500
Date: Tue, 2 Nov 2004 10:31:53 +0100
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Map extra keys on compaq evo
Message-ID: <20041102093151.GA24915@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
References: <20041031213859.GA6742@elf.ucw.cz> <20041101140717.GA1180@ucw.cz> <20041101172809.GB23341@elf.ucw.cz> <200411012318.45690.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411012318.45690.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 11:18:45PM -0500, Dmitry Torokhov wrote:

> I actually would love to set up X to have 2 keyboards with 2 different
> layouts, I wonder if event keyboard driver can help here...
[...]

I did this lately with my sonypi driver and yes, using the event keyboard
driver does permit having multiple keyboards with X.

Unfortunately, it also seems that the XKB layout is common for all
keyboards, meaning that the last keyboard defined in xorg.conf
overrides the layout for *each* keyboard.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
