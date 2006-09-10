Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWIJBNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWIJBNa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 21:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWIJBN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 21:13:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22205 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965065AbWIJBN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 21:13:28 -0400
Date: Sat, 9 Sep 2006 21:20:29 -0400
From: Dave Jones <davej@redhat.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reserve a boot-loader ID number for Xen
Message-ID: <20060910012029.GA26959@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Andrew Morton <akpm@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <45035472.8000506@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45035472.8000506@goop.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 04:55:30PM -0700, Jeremy Fitzhardinge wrote:

 > @@ -181,6 +181,7 @@ filled out, however:
 >  	5  ELILO
 >  	7  GRuB
 >  	8  U-BOOT
 > +	9  Xen
 >  
 >  	Please contact <hpa@zytor.com> if you need a bootloader ID
 >  	value assigned.
 > ===================================================================
 > --- a/Documentation/i386/zero-page.txt
 > +++ b/Documentation/i386/zero-page.txt
 > @@ -63,6 +63,10 @@ 0x210	char		LOADER_TYPE, = 0, old one
 >  				2 for bootsect-loader
 >  				3 for SYSLINUX
 >  				4 for ETHERBOOT
 > +				5 for ELILO
 > +				7 for GRuB
 > +				8 for U-BOOT
 > +				9 for Xen
 >  				V = version
 >  0x211	char		loadflags:

Is there a reason 6 has been skipped ?

	Dave

