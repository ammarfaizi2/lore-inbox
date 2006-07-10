Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbWGJU5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbWGJU5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbWGJU5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:57:32 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:40241 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965201AbWGJU5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:57:31 -0400
Date: Mon, 10 Jul 2006 13:56:20 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Miller <davem@davemloft.net>, auke-jan.h.kok@intel.com,
       jgarzik@pobox.com, pavel@ucw.cz, yi.zhu@intel.com,
       jketreno@linux.intel.com, netdev@vger.kernel.org,
       linville@tuxdriver.com, linux-kernel@vger.kernel.org,
       mark.fasheh@oracle.com
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
Message-ID: <20060710205620.GO11640@ca-server1.us.oracle.com>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	David Miller <davem@davemloft.net>, auke-jan.h.kok@intel.com,
	jgarzik@pobox.com, pavel@ucw.cz, yi.zhu@intel.com,
	jketreno@linux.intel.com, netdev@vger.kernel.org,
	linville@tuxdriver.com, linux-kernel@vger.kernel.org,
	mark.fasheh@oracle.com
References: <20060710152032.GA8540@elf.ucw.cz> <44B2940A.2080102@pobox.com> <44B29C8A.8090405@intel.com> <20060710.114717.44959528.davem@davemloft.net> <1152557518.4874.79.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152557518.4874.79.camel@laptopd505.fenrus.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 08:51:58PM +0200, Arjan van de Ven wrote:
> > Besides, the initramfs runs long after the driver init routine
> > runs which is when the firmware needs to be available.
> 
> .. unless you use sysfs to do a fake hotunplug + replug the device, at
> which point the driver init routine runs again.

	Can we document how to do that?  I've wanted to synthesize such
things before, and I couldn't quite reason how.
	In my case, I had RHEL4 module-init-tools that don't wait for
modprobe, so I had to compile in scsi and qla2x00, but the qla2x00 needs
firmware, and it's too early...etc.

Joel

-- 

"Baby, even the losers
 Get luck sometimes.
 Even the losers
 Keep a little bit of pride."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
