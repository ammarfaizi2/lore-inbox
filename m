Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVGVWgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVGVWgo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 18:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVGVWgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 18:36:44 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:39285 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261434AbVGVWgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 18:36:43 -0400
Date: Sat, 23 Jul 2005 00:09:20 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Johannes Stezenbach <js@linuxtv.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: Why build empty object files in drivers/media?
Message-ID: <20050723000920.GA8047@mars.ravnborg.org>
References: <200507212309_MC3-1-A534-95EE@compuserve.com> <20050722194600.GA8757@mars.ravnborg.org> <87oe8uleui.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87oe8uleui.fsf@goat.bogus.local>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 11:18:13PM +0200, Olaf Dietsche wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> > +obj-$(CONFIG_VIDEO_DEV) := video/
> > +obj-$(CONFIG_VIDEO_DEV) := radio/
> 
>   s/VIDEO/RADIO/

If you look at drivers/media/radio/Kconfig you will see that the above
is coorect. Thre is no CONFIG_RADIO_DEV.

	Sam
