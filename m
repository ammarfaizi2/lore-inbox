Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbULOTSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbULOTSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbULOTQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:16:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:59036 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262453AbULOTPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:15:38 -0500
Date: Wed, 15 Dec 2004 11:15:23 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select HOTPLUG
Message-ID: <20041215191523.GA10005@kroah.com>
References: <20041202024254.GL5148@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202024254.GL5148@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 03:42:54AM +0100, Adrian Bunk wrote:
> The patch below changes all dependencies on HOTPLUG to selects.
> 
> The help text of HOTPLUG is adjusted in a way, that manually selecting 
> it is only required for external modules.
> 
> If an option already depends on PCMCIA or selects FW_LOADER an explicit 
> select of HOTPLUG is not required.

Applied, thanks.

greg k-h
