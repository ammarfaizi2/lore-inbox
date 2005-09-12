Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVILNxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVILNxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbVILNxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:53:12 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:54991 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S1750838AbVILNxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:53:12 -0400
Subject: Re: Universal method to start a script at boot
From: Brad Tilley <rtilley@vt.edu>
To: Michael Clark <michael@metaparadigm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43250150.20308@metaparadigm.com>
References: <1126462329.4324737923c2d@wmtest.cc.vt.edu>
	 <1126462467.43247403c2e1c@wmtest.cc.vt.edu>
	 <43250150.20308@metaparadigm.com>
Content-Type: text/plain
Organization: Virginia Tech Athletics
Date: Mon, 12 Sep 2005 09:52:45 -0400
Message-Id: <1126533165.7503.0.camel@athop1.ath.vt.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 12:17 +0800, Michael Clark wrote:
> Brad Tilley wrote:
> 
> >This is off-topic and I apologize. However, I think some here could answer
> >this.
> >
> >  
> >
> >>Is there a standard way to start a script or program at boot that will work
> >>on any Linux kernel/distro no matter which init system is being used or how it
> >>has been configured? Probably not, but I thought someone here could possibly
> >>answer this.
> >>    
> >>
> 
> You could use the LSB conforming method of writing and installing
> an init script:
> 
> http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/iniscrptact.html
> http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/iniscrptfunc.html
> http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/initscrcomconv.html
> http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/initsrcinstrm.html
> 
> Most of the main distros support this (Fedora, RHEL, SuSE,
> Mandriva, Debian, ...). Not to say all of them ship with the
> LSB support packages installed by default. Some do some don't.
> 
> On Debian I need to do an "apt-get install lsb".
> 
> ~mc
> 

Thank you. I think this is the best approach for me.

