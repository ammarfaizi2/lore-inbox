Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUFFTsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUFFTsg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 15:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbUFFTsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 15:48:36 -0400
Received: from gprs214-14.eurotel.cz ([160.218.214.14]:35713 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264085AbUFFTsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 15:48:31 -0400
Date: Sun, 6 Jun 2004 21:48:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6] Mousedev - tapping support for touchpads in absolute mode (Synaptics)
Message-ID: <20040606194819.GC10081@elf.ucw.cz>
References: <200406050252.45260.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406050252.45260.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The patch below implements tapping support for touchpads working in absolute
> mode so Synaptics users do not need use psmouse.proto=imps to have tapping in
> absence of native X driver/GPM support. The new kernel parameter
> mousedev.tap_time=<msecs> controls the feature, use 0 to disable tapping.
> 
> The patch is on top of other mousedev patch I posted earlier.

Heh, and this should also help on compaq nx5k which has synaptics but
does not support tapping. Good.

									Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
