Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWCXUqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWCXUqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 15:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWCXUqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 15:46:49 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:64158
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751224AbWCXUqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 15:46:48 -0500
Date: Fri, 24 Mar 2006 12:46:24 -0800
From: Greg KH <gregkh@suse.de>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: [RFC] [PATCH] Move drivers/usb/media to drivers/media/video
Message-ID: <20060324204624.GA2928@suse.de>
References: <1143231086.4961.24.camel@praia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143231086.4961.24.camel@praia>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 05:11:26PM -0300, Mauro Carvalho Chehab wrote:
> Because of historic reasons, there are two separate directories with
> V4L stuff. Most drivers are located at driver/media/video. However, some
> code for USB Webcams were inserted under drivers/usb/media.
> 
> This makes difficult for module authors to know were things should be.
> Also, makes Kconfig menu confusing for normal users.
> 
> This patch moves all V4L content under drivers/usb/media to
> drivers/media/video, and fixes Kconfig/Makefile entries.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

It's probably best to do this as a git patch and send it to Linus that
way, so he can just pull it.

thanks,

greg k-h
