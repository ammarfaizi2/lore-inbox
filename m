Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263707AbUJ3Lo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263707AbUJ3Lo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbUJ3Lo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:44:26 -0400
Received: from mproxy.gmail.com ([216.239.56.247]:27449 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263707AbUJ3LoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:44:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Z7siXQLK5KB87jeFmFlcPMYq1r5sJttRPXfiVTmTQs1ObJzp7LT8JozlvyuM1+A3S4vt3e71qta2EgSmQiFKv+UmAaq3cDZV9E5EWdjs4YgiaKXs5CqEmnuPwk4RKrHslMDioWuhNErFsopPlcgL0e+/mfcnoYtzVBceFkq9aLY=
Message-ID: <21d7e99704103004445605730d@mail.gmail.com>
Date: Sat, 30 Oct 2004 21:44:22 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-mm1, class_simple_* and GPL addition
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041029205505.GB30638@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041027135052.GE32199@gamma.logic.tuwien.ac.at>
	 <20041027153715.GB13991@kroah.com>
	 <200410272012.44361.dtor_core@ameritech.net>
	 <20041029205505.GB30638@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> So we can change things, little things like this can help everyone out,
> even if I'm going to get a ton of nvidia user hate mail directed to me
> after the next kernel comes out...
> 
> Remember, binary kernel modules are a leach on our community.

True, but now with this code change, you have (acceptable or not) made
binary modules second class citizens of the kernel, they cannot use
the hotplugging or any of the new device model type code, they are
always going to be second best and more of a problem for users, udev
for binary modules is now probably not possible, if you take Linus's
view that binary modules that are not derived from the kernel are not
necessarily GPL then we've made them not able to be as good as other
kernel modules, I don't think we'll annoy any binary module vendors
we'll just piss off users...

personally I thought the whole _GPL thing was meant to denote
interfaces that showed that code was derived from the kernel so should
be under the GPL, interfaces that all drivers should use to work with
Linux are not IMHO proving the code is derived from the kernel, they
still could be derived from another project but just want to be a 2.6
device driver and use hotplug or sysfs.... so they can without fear
lie about their status to use these interfaces... as Linus has said
previously these interfaces are advisory, only lawyers/judges can
decide if they are enforceable....

Dave.
