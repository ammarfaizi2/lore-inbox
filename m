Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbTIDRzT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbTIDRyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:54:37 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:11268
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S265346AbTIDRxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:53:05 -0400
Date: Thu, 4 Sep 2003 10:53:02 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mehmet Ceyran <mceyran@web.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: drivers/sound/i810_audio.c bug and patch
Message-ID: <20030904175302.GA13676@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mehmet Ceyran <mceyran@web.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030904014327.GK16361@matchmail.com> <1062673302.21667.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062673302.21667.13.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 12:01:43PM +0100, Alan Cox wrote:
> On Iau, 2003-09-04 at 02:43, Mike Fedyk wrote:
> > >  		set_current_state(TASK_UNINTERRUPTIBLE);
> > >  		schedule_timeout(HZ/20);
> 
> > Why busy wait especially when you can sleep 1ms each time and poll less?
> 
> I think you read it wrong - its sleeping...

Yep, you're right.
