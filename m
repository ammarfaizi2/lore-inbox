Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263567AbVBFJRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbVBFJRG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 04:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbVBFJRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 04:17:06 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:38554 "EHLO suse.de")
	by vger.kernel.org with ESMTP id S263567AbVBFJQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 04:16:53 -0500
Date: Sun, 6 Feb 2005 10:17:13 +0100
From: Vojtech Pavlik <vojtech@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add resume support to serio bus.
Message-ID: <20050206091713.GA8775@ucw.cz>
References: <200502060246.20878.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502060246.20878.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 02:46:20AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> This patch adds resume support to serio_bus based on serio reconnect
> framework so now not only i8042 ports will be re-initialized at resume.
> It also removes serio_reconnect calls from i8042 as they no longer
> needed.
> 
> Tested on S4 (swsusp) with Synaptics touchpad.

Nice. Applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
