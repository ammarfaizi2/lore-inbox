Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263152AbVBDNQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbVBDNQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbVBDNQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:16:48 -0500
Received: from styx.suse.cz ([82.119.242.94]:45034 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S263633AbVBDNQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:16:40 -0500
Date: Fri, 4 Feb 2005 14:16:58 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/4] Make mousedev.c report all events to user space immediately
Message-ID: <20050204131658.GD10424@ucw.cz>
References: <m34qgz9pj5.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34qgz9pj5.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 11:31:26AM +0100, Peter Osterlund wrote:
> mousedev_packet() incorrectly clears list->ready when called with
> "tail == head - 1".  The effect is that the last mouse event from the
> hardware isn't reported to user space until another hardware mouse
> event arrives.  This can make the left mouse button get stuck when
> tapping on a touchpad.  When this happens, the button doesn't unstick
> until the next time you interact with the touchpad.
> 
> Signed-off-by: Peter Osterlund <petero2@telia.com>

Thanks, applied. Btw, I'm missing your patch 2/4 - it got lost somewhere.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
