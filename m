Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWFNFYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWFNFYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWFNFYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:24:08 -0400
Received: from eazy.amigager.de ([213.239.192.238]:60397 "EHLO
	eazy.amigager.de") by vger.kernel.org with ESMTP id S964884AbWFNFYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:24:06 -0400
Date: Wed, 14 Jun 2006 07:24:10 +0200
From: Tino Keitel <tino.keitel@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.19 + gcc-4.1.1
Message-ID: <20060614052410.GA4281@dose.home.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.63.0606131906230.2368@bigred.russwhit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606131906230.2368@bigred.russwhit.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 19:23:30 -0700, Russell Whitaker wrote:
> hi
> 
> First, I did this:
>   made kernel with cpu=486, gcc-3.3.6
>   worked fine.
> 
> Next, changed cpu to k6, all else same.
>   worked fine.
> 
> Then, after mrproper, rebuilt with gcc-4.1.1, no other changes.
>   compiles ok, installs ok. But, when attempting to load a module, get
>   the following message:  version magic '2.6.16.19via K6 gcc-4.1',
>   should be '2.6.16.19via 486 gcc-3.3'

Did you reboot with the kernel built with gcc 4.1.1? The gcc version in
/proc/version has to match the gcc version of the module you want to
load..

Regards,
Tino
