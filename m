Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272555AbTGZQqF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272557AbTGZQqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:46:05 -0400
Received: from mail.kroah.org ([65.200.24.183]:11180 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272555AbTGZQqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:46:01 -0400
Date: Sat, 26 Jul 2003 13:00:44 -0400
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?Ga=EBl?= Le Mignot <kilobug@freesurf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1, usbfs: devgid parameter seems ignored
Message-ID: <20030726170044.GB3168@kroah.com>
References: <plopm3ptjy3ovr.fsf@drizzt.kilobug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <plopm3ptjy3ovr.fsf@drizzt.kilobug.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 12:02:48PM +0200, Gaël Le Mignot wrote:
> 
> Hello,
> 
> I've tried Linux 2.6.0-test1, -ac1 and -ac3 on two computers, and each
> time the options passed (like devgid or devmode) to usbfs when mouting
> it seem to be ignored:
> 
> (kilobug@drizzt, 8) ~ $ sudo mount none -t usbfs /proc/bus/usb -o devgid=143,devbmode=0664

Hm, you are right, thanks for reporting this.

Could you possibly dump this info into a new bug in the kernel bug
tracking system at bugzilla.kernel.org so I don't forget to fix this?

thanks,

greg k-h
