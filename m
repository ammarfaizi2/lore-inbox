Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVCDGzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVCDGzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVCDGzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:55:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:27819 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262520AbVCDGzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:55:15 -0500
Date: Thu, 3 Mar 2005 22:54:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: chrisw@osdl.org, jgarzik@pobox.com, olof@austin.ibm.com, paulus@samba.org,
       rene@exactcode.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/
 Altivec
Message-Id: <20050303225445.165f34da.akpm@osdl.org>
In-Reply-To: <20050304064759.GP5389@shell0.pdx.osdl.net>
References: <422756DC.6000405@pobox.com>
	<16935.36862.137151.499468@cargo.ozlabs.ibm.com>
	<20050303225542.GB16886@austin.ibm.com>
	<20050303175951.41cda7a4.akpm@osdl.org>
	<20050304022424.GA26769@austin.ibm.com>
	<20050304055451.GN5389@shell0.pdx.osdl.net>
	<20050303220631.79a4be7b.akpm@osdl.org>
	<4227FC5C.60707@pobox.com>
	<20050304062016.GO5389@shell0.pdx.osdl.net>
	<20050303222335.372d1ad2.akpm@osdl.org>
	<20050304064759.GP5389@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> > And it's a temp-fix - it'll be addressed by other means in 2.6.12.
>  > 
>  > What do we do?
> 
>  IMO, we have to rely on Dmitry's judgement.  Is it critical (i.e. broke
>  laptops how)?  Can it be worked around with the i8042.noacpi boot param?
>  If so, I don't think it fits the bill as critical.

Well.  It was critical for 2.6.11, but it didn't make it :(

So people whose keyboards don't work need to either update to 2.6.11.1 or
add i8042.noacpi=1.  <rekicks self>

But it's just a for-instance.

