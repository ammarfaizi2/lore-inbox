Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWCHVTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWCHVTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWCHVTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:19:03 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6925 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932271AbWCHVTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:19:01 -0500
Date: Wed, 8 Mar 2006 22:19:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kyler Laird <kyler-keyword-lkml00.e701c2@lairds.com>,
       mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
Subject: Re: drivers/media/video/saa7115.c misreports max. value of contrast and saturation
Message-ID: <20060308211900.GM4006@stusta.de>
References: <20060215051908.GF13033@snout>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215051908.GF13033@snout>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 12:19:08AM -0500, Kyler Laird wrote:

> For changes to V4L2_CID_CONTRAST and V4L2_CID_SATURATION, the value is
> checked by "if (ctrl->value < 0 || ctrl->value > 127)" yet the maximum
> value in v4l2_queryctrl is set to 255 for both of these items.  This
> means that programs (like MythTV) which set the contrast and saturation
> to the midvalue (127) get *full* contrast and saturation.  (It's not
> pretty.)
> 
> Setting the maximum values to 127 solves this problem.

Mauro, can you comment on this issue?

> Please copy me on responses.
> 
> Thank you.
> 
> --kyler

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

