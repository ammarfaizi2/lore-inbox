Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbVCKCEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbVCKCEc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbVCKCEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:04:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:31156 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263113AbVCKCDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:03:09 -0500
Date: Thu, 10 Mar 2005 18:04:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: davej@redhat.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
In-Reply-To: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0503101802090.2530@ppc970.osdl.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Mar 2005, Paul Mackerras wrote:
> 
> Oh, and by the way, I have 3D working relatively well on my G5 with a
> 64-bit kernel (and 32-bit X server and clients), which is why I care
> about AGP 3.0 support. :)

Ok, I can't even compile it on my G5, so you're obviously withholding some 
patches you shouldn't ;)

Anyway, I fixed up the AGP discovery differently from your patch, so you 
should check that my version works for you. DaveJ, please give it a 
once-over too, since my G5 doesn't do the AGP thing yet.

		Linus
