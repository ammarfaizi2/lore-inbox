Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVCDQ3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVCDQ3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 11:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVCDQ3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:29:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:15510 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262922AbVCDQ20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:28:26 -0500
Date: Fri, 4 Mar 2005 08:27:55 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, dtor_core@ameritech.net
Cc: Chris Wright <chrisw@osdl.org>, jgarzik@pobox.com, olof@austin.ibm.com,
       paulus@samba.org, rene@exactcode.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
Message-ID: <20050304162755.GA28179@kroah.com>
References: <422756DC.6000405@pobox.com> <16935.36862.137151.499468@cargo.ozlabs.ibm.com> <20050303225542.GB16886@austin.ibm.com> <20050303175951.41cda7a4.akpm@osdl.org> <20050304022424.GA26769@austin.ibm.com> <20050304055451.GN5389@shell0.pdx.osdl.net> <20050303220631.79a4be7b.akpm@osdl.org> <4227FC5C.60707@pobox.com> <20050304062016.GO5389@shell0.pdx.osdl.net> <20050303222335.372d1ad2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303222335.372d1ad2.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 10:23:35PM -0800, Andrew Morton wrote:
> From: Dmitry Torokhov <dtor_core@ameritech.net>
> 
> Some ACPI-related changes were recently made to i8042 discovery for ia64. 
> Unfortunately this broke a significant number of Dell laptops due to their
> having incorrect BIOS tables.
> 
> So, for now, arrange for the new code to be ia64-only.
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Ok, based on consensus, I've applied this one too.

Yes, we will get a bk-stable-commits tree up and running, still working
out the infrastructure...

thanks,

greg k-h
