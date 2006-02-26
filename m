Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWB0NLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWB0NLT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 08:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWB0NLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 08:11:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39948 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751149AbWB0NLS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 08:11:18 -0500
Date: Sun, 26 Feb 2006 17:54:54 +0000
From: Pavel Machek <pavel@ucw.cz>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: NetDev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [Announce] Intel PRO/Wireless 3945ABG Network Connection
Message-ID: <20060226175454.GA2429@ucw.cz>
References: <43FF88E6.6020603@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FF88E6.6020603@linux.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> As a result of this change, some of the capabilities currently required
> to be provided on the host include enforcement of regulatory limits for
> the radio transmitter (radio calibration, transmit power, valid
> channels, 802.11h, etc.)  In order to meet the requirements of all
> geographies into which our adapters ship (over 100 countries) we have
> placed the regulatory enforcement logic into a user space daemon that
> we provide as a binary under the same license agreement as the
> microcode.  We provide that binary pre-compiled as both a 32-bit and
> 64-bit application.  The daemon utilizes a sysfs interface exposed by
> the driver in order to communicate with the hardware and configure the
> required regulatory parameters.

Well, that means no luck to sparc users.... And I hope kernel<->user
interface is nice, clean and documented.

-- 
Thanks, Sharp!
