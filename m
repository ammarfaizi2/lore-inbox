Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbTIYDyj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 23:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbTIYDyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 23:54:39 -0400
Received: from adsl-68-73-156-198.dsl.ipltin.ameritech.net ([68.73.156.198]:63119
	"EHLO coreip.homeip.net") by vger.kernel.org with ESMTP
	id S261676AbTIYDyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 23:54:39 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Dan <overridex@punkass.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6: joydev is too eager claiming input devices
Date: Wed, 24 Sep 2003 22:54:21 -0500
User-Agent: KMail/1.5.3
References: <1064459037.19555.3.camel@nazgul.overridex.net>
In-Reply-To: <1064459037.19555.3.camel@nazgul.overridex.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309242254.21630.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 September 2003 10:03 pm, Dan wrote:
> This patch seems to have broken my Logitech Wingman Action usb gamepad,
> it shows as connected but isn't claimed by joydev... another joystick I
> have (saitek cyborg usb gold) works fine, and the logitech worked in
> previous 2.5/6.x kernels so I'm guessing this patch is to blame, I'm on
> 2.6.0-test5-mm1, is there any info from the joystick I can provide you
> with to fix it?  I'm not sure where to look, thanks -Dan
>

Could you post contents of your /proc/bus/input/devices please?

Dmitry
