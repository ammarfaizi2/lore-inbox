Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTHWAWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 20:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTHWAWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 20:22:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:40073 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263203AbTHWAWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 20:22:09 -0400
Date: Fri, 22 Aug 2003 17:22:03 -0700
From: Greg KH <greg@kroah.com>
To: Luis Medinas <metalgodin@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6-testXX and alcatel speedtouch usb modem
Message-ID: <20030823002203.GA11633@kroah.com>
References: <20030822110830.15262.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822110830.15262.qmail@linuxmail.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 07:08:30PM +0800, Luis Medinas wrote:
> >I try to make this modem working.
> >It works very well on kernel 2.4 series.
> >It work with some kernel 2.6 until test2-mm1.
> >But since test2-mm1, the newer kernel doesn't work anymore.
> >There is 2 related drivers for this modem.
> >The one which is included in the kernel and which can be found here :
> >http://www.linux-usb.org/SpeedTouch/
> >and the one which I've always used until now :
> >speedtouch.sourceforge.net
> 
> >when I notice that the old one doesn't work anymore, I try with the driver 
> >which included in the kernel, without success.
> 
> >It crashed when I do "pppd call adsl".
> >I can load the firmware.
> 
> Looks like this is happening to all 2.6.0-test3 users with speedtouch
> usb modems And i heard that speedtouch.sf.net developers want to leave
> 2.6 tree stabilize more a little bit to continue develop drivers with
> the correct support.

Um, as you have helped narrow down where the problem happened, I would
_really_ suggest they get involved in order to get the 2.6 tree to a
"stable" state.  Otherwise this bug is not going to get fixed due to the
fact that this is the only driver having problems right now.

thanks,

greg k-h
