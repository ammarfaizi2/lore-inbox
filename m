Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWJMGgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWJMGgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 02:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWJMGgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 02:36:54 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:7371 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751039AbWJMGgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 02:36:53 -0400
Date: Fri, 13 Oct 2006 08:37:26 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jaroslav Kysela <perex@suse.cz>, Andrew Morton <akpm@osdl.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>,
       Castet Matthieu <castet.matthieu@free.fr>,
       Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] Driver core: Don't ignore bus_attach_device() retval
Message-ID: <20061013083726.557b1fed@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.44L0.0610121718110.8064-100000@iolanthe.rowland.org>
References: <20061012191730.395bc538@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0610121718110.8064-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed-Claws 2.5.3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 17:41:46 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> I don't care too much one way or another.  Although missing symlinks might 
> cause problems for certain user programs.

Hm, yes, that might happen. I'll give it some more thought.

> No, I meant device_bind_driver().  Try to create the symlinks first, and 
> if that succeeds (or if you don't care when it fails) then call 
> driver_bound().  This confusion may be a result of looking at different 
> source trees.

Ah, ok, I was looking at current git.

> Do you want to write another patch?

I'll see what I can come up with.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
