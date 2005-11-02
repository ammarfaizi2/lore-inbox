Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVKBAmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVKBAmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVKBAmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:42:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16905 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932078AbVKBAmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:42:04 -0500
Date: Wed, 2 Nov 2005 01:41:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Steven French <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, samba-technical@lists.samba.org,
       sfrench@samba.org
Subject: Re: [2.6 patch] let CIFS_EXPERIMENTAL depend on EXPERIMENTAL
Message-ID: <20051102004159.GB8009@stusta.de>
References: <20051031111359.GI8009@stusta.de> <OFB4C871B0.47755748-ON872570AB.0059A91D-862570AB.00596022@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB4C871B0.47755748-ON872570AB.0059A91D-862570AB.00596022@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 10:21:36AM -0600, Steven French wrote:
> 
> If users really remember that CONFIG_EXPERIMENTAL does not enable anything
> than it is probably a good idea -

I'd express it differently:

People interested in experimental options like CIFS_EXPERIMENTAL did 
already enable EXPERIMENTAL.

> There is a minor problem - ie that there are some features in CIFS that
> with 2.6.14 out are no longer really experimental that need to be pulled
> out of the ifdef.   I have a pretty big cifs merge to do, but I have no
> real problem with your patch (we have enough time to add one or two more
> cifs config options, clean up others)

I don't see any problem with this.

It's quite normal that code moves out of an EXPERIMENTAL option once 
it's matured.

> Steve French

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

