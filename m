Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVCDHRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVCDHRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVCDHPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:15:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60647 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262590AbVCDHPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:15:12 -0500
Message-ID: <42280AEC.4020405@pobox.com>
Date: Fri, 04 Mar 2005 02:14:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: chrisw@osdl.org, olof@austin.ibm.com, paulus@samba.org, rene@exactcode.de,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
References: <422756DC.6000405@pobox.com>	<16935.36862.137151.499468@cargo.ozlabs.ibm.com>	<20050303225542.GB16886@austin.ibm.com>	<20050303175951.41cda7a4.akpm@osdl.org>	<20050304022424.GA26769@austin.ibm.com>	<20050304055451.GN5389@shell0.pdx.osdl.net>	<20050303220631.79a4be7b.akpm@osdl.org>	<4227FC5C.60707@pobox.com>	<20050304062016.GO5389@shell0.pdx.osdl.net>	<20050303222335.372d1ad2.akpm@osdl.org>	<20050304064759.GP5389@shell0.pdx.osdl.net>	<422808A4.105@pobox.com> <20050303231203.411d204d.akpm@osdl.org>
In-Reply-To: <20050303231203.411d204d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>The boot param is rather lame, IMO, since it affects a -bunch- of 
>> laptops.  But whatever...
> 
> 
> My main desktop (a recent Dell), running 2.6.11-rc4-mm1 needs i8042.nopnp=1
> (sic.  It got renamed) so I can type stuff too.  (rerekicks self). I expect
> this machine would require i8042.noacpi=1 if it was running 2.6.11.
> 
> Lots of machines are affected.  It's a bit of a howler.

Definitely a linux-release candidate then.

On a side note, it would be nice to give you access to push things into 
the linux-release tree yourself.

	Jeff


