Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVCNITH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVCNITH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 03:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVCNITH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 03:19:07 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:41174 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261337AbVCNITD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 03:19:03 -0500
Date: Mon, 14 Mar 2005 09:19:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stephen Evanchik <evanchsa@gmail.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11] IBM TrackPoint support
Message-ID: <20050314081949.GA2309@ucw.cz>
References: <a71293c2050313210230161278@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71293c2050313210230161278@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 12:02:13AM -0500, Stephen Evanchik wrote:

> Here's the latest patch for TracKPoint devices. I have changed the
> sysfs filenames to be more descriptive for commonly used attributes. I
> also implemented the set_properties flag for initialization.
> 
> It patches against 2.6.11 and 2.6.11.3 however I have not tested it
> with 2.6.11.3 .
> 
> Any comments are appreciated.

> +/*
> + * Mode manipulation
> + */
> +#define TP_SET_SOFT_TRANS (0x4E) /* Set mode */
> +#define TP_CANCEL_SOFT_TRANS (0xB9) /* Cancel mode */
> +#define TP_SET_HARD_TRANS (0x45) /* Mode can only be set */

What exactly is transparent mode? 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
