Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbTIDLCs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 07:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTIDLCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 07:02:48 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:48338 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264912AbTIDLCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 07:02:47 -0400
Subject: Re: drivers/sound/i810_audio.c bug and patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Mehmet Ceyran <mceyran@web.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030904014327.GK16361@matchmail.com>
References: <200309031429.01672.m.c.p@wolk-project.de>
	 <005d01c37273$88183840$0100a8c0@server1>
	 <20030904014327.GK16361@matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062673303.21777.14.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Thu, 04 Sep 2003 12:01:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-04 at 02:43, Mike Fedyk wrote:
> >  		set_current_state(TASK_UNINTERRUPTIBLE);
> >  		schedule_timeout(HZ/20);

> Why busy wait especially when you can sleep 1ms each time and poll less?

I think you read it wrong - its sleeping...

