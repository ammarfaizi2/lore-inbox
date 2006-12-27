Return-Path: <linux-kernel-owner+w=401wt.eu-S932876AbWL0AzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876AbWL0AzN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 19:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932878AbWL0AzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 19:55:13 -0500
Received: from ozlabs.org ([203.10.76.45]:36544 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932876AbWL0AzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 19:55:12 -0500
X-Greylist: delayed 1390 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 19:55:11 EST
Subject: Re: [PATCH] romsignature/checksum cleanup
From: Rusty Russell <rusty@rustcorp.com.au>
To: Rene Herman <rene.herman@gmail.com>, Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <458F20FB.7040900@gmail.com>
References: <458EEDF7.4000200@gmail.com>  <458F20FB.7040900@gmail.com>
Content-Type: text/plain
Date: Wed, 27 Dec 2006 11:31:52 +1100
Message-Id: <1167179512.16175.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-25 at 01:53 +0100, Rene Herman wrote:
> Rene Herman wrote:
> 
> > Use adding __init to romsignature() (it's only called from probe_roms() 
> > which is itself __init) as an excuse to submit a pedantic cleanup.
> 
> Hmm, by the way, if romsignature() needs this probe_kernel_address() 
> thing, why doesn't romchecksum()?

I assume it's all in the same page, but CC'ing Zach is easier than
reading the code 8)

Rusty.


