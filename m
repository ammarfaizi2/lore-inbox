Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270606AbUJUA3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270606AbUJUA3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270505AbUJUAQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:16:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:49076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270557AbUJUAPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:15:35 -0400
Date: Wed, 20 Oct 2004 16:56:21 -0700
From: Greg KH <greg@kroah.com>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Instances of visor us devices are not deleted (2.6.9-rc4-mm1)
Message-ID: <20041020235621.GC16737@kroah.com>
References: <20041020061647.GA20692@gamma.logic.tuwien.ac.at> <20041020070056.GA15620@kroah.com> <20041020111800.GA6569@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020111800.GA6569@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 01:18:00PM +0200, Norbert Preining wrote:
> Hi Greg!
> 
> On Mit, 20 Okt 2004, Greg KH wrote:
> > Hm, no it isn't.  Are you sure that userspace doesn't still have the
> > device nodes open?  If they do, the ttyUSB number will not be released
> > until that happens.
> 
> Ah, ok. So the culprit is gnome-pilot listening for HotSync events. 
> 
> I thought that as soon as the unit/usb device is disconnected, also the
> device numbers are released.

Nope, sorry.

> But then: How to cope with problems like this? REcurring plugging and
> unplugging and a program listening to this?

fix the userspace program :)

Good luck,

greg k-h
