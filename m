Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVCDHFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVCDHFm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVCDHFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:05:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19943 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262503AbVCDHFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:05:25 -0500
Message-ID: <422808A4.105@pobox.com>
Date: Fri, 04 Mar 2005 02:05:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, olof@austin.ibm.com, paulus@samba.org,
       rene@exactcode.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
References: <422756DC.6000405@pobox.com> <16935.36862.137151.499468@cargo.ozlabs.ibm.com> <20050303225542.GB16886@austin.ibm.com> <20050303175951.41cda7a4.akpm@osdl.org> <20050304022424.GA26769@austin.ibm.com> <20050304055451.GN5389@shell0.pdx.osdl.net> <20050303220631.79a4be7b.akpm@osdl.org> <4227FC5C.60707@pobox.com> <20050304062016.GO5389@shell0.pdx.osdl.net> <20050303222335.372d1ad2.akpm@osdl.org> <20050304064759.GP5389@shell0.pdx.osdl.net>
In-Reply-To: <20050304064759.GP5389@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> IMO, we have to rely on Dmitry's judgement.  Is it critical (i.e. broke
> laptops how)?  Can it be worked around with the i8042.noacpi boot param?
> If so, I don't think it fits the bill as critical.

If it was critical for 2.6.11, I would think it's critical for 2.6.11.1.

One would hope its at least tested on one affected laptop.

The boot param is rather lame, IMO, since it affects a -bunch- of 
laptops.  But whatever...

	Jeff


