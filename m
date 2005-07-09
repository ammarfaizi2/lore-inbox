Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVGIO0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVGIO0q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 10:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVGIO0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 10:26:45 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:7314 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261430AbVGIO0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 10:26:38 -0400
Date: Sat, 9 Jul 2005 16:27:06 +0200
From: Mattia Dongili <malattia@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: Synaptics Touchpad not detected in 2.6.13-rc2
Message-ID: <20050709142706.GA4181@inferi.kami.home>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dmitry Torokhov <dtor@mail.ru>
References: <20050708125537.GA4191@inferi.kami.home> <20050708162908.715.qmail@web81301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708162908.715.qmail@web81301.mail.yahoo.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.13-rc2-mm1-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 09:29:08AM -0700, Dmitry Torokhov wrote:
[...]
> Does it help if you boot with "usb-handoff" kernel option? Another
> one would be "i8042.nomux". Btw, does your laptop have external
> PS/2 ports?

Ok, it seems I can now reliably reproduce the wrong detection (by
removing the power supply before a cold boot) and 'usb-handoff'
definitely helps.

Oh, and I don't have any extra ps/2 port available.

-- 
mattia
:wq!
