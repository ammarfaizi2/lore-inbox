Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTICSrP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTICSpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:45:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:59556 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264324AbTICSmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:42:39 -0400
Date: Wed, 3 Sep 2003 11:41:40 -0700
From: Greg KH <greg@kroah.com>
To: Justin Cormack <justin@street-vision.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Sweetman <ed.sweetman@wmich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: devfs to be obsloted by udev?
Message-ID: <20030903184140.GA1651@kroah.com>
References: <3F54A4AC.1020709@wmich.edu> <200309022219.02549.bzolnier@elka.pw.edu.pl> <1062581929.30060.197.camel@lotte.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062581929.30060.197.camel@lotte.street-vision.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 10:38:48AM +0100, Justin Cormack wrote:
> On Tue, 2003-09-02 at 21:19, Bartlomiej Zolnierkiewicz wrote:
> > 
> > initramfs
> 
> which seems to have been postponed to 2.7.

No, the initramfs code is in 2.6 right now.  The boot processes uses it
too.

What has been postponed to 2.7 is the moving of some of the boot code to
use it some more.  But that's really just a matter of someone doing the
work (and adding it to the build process properly.)  There are a few
patches floating around somewhere that do this with the exception of
intregrating into the build.

thanks,

greg k-h
