Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWJFLZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWJFLZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWJFLZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:25:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36055 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751212AbWJFLZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:25:17 -0400
Date: Fri, 6 Oct 2006 13:25:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] error to be returned while suspended
Message-ID: <20061006112501.GK29353@elf.ucw.cz>
References: <200610052325.39690.oliver@neukum.org> <Pine.LNX.4.44L0.0610051732190.7346-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610051732190.7346-100000@iolanthe.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-10-05 17:45:25, Alan Stern wrote:
> On Thu, 5 Oct 2006, Oliver Neukum wrote:
> 
> > I have a few observations, but no solution either:
> > - if root tells a device to suspend, it shall do so
> 
> Probably everyone will agree on that.

Not sure... I'm not sure if root is in business of telling devices
what to do...

> > - there's no direct connection between power save and open()

...if you want to suspend device X, close its device file/ifconfig it
down/hdparm -y it.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
