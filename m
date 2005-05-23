Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVEWQky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVEWQky (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 12:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVEWQkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 12:40:53 -0400
Received: from colin.muc.de ([193.149.48.1]:30731 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261912AbVEWQkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 12:40:46 -0400
Date: 23 May 2005 18:40:46 +0200
Date: Mon, 23 May 2005 18:40:46 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: zwane@arm.linux.org.uk, discuss@x86-64.org, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/4] CPU hot-plug support for x86_64
Message-ID: <20050523164046.GB39821@muc.de>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050520221622.124069000@csdlinux-2.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 03:16:22PM -0700, Ashok Raj wrote:
> Andi: You had mentioned that you would not prefer to replace the broadcast IPI
>       with the mask version for performance. Currently this seems to be the
> 	  most optimal way without putting a sledge hammer on the cpu_up process.

I already put a sledgehammer to __cpu_up with that last
patch. Some more hammering surely wouldnt be a big issue. Unlike i386
we actually still have a chance to test all relevant platforms, so I 
dont think it is a big issue.

What changes did you plan?

P.S.: An alternative would be to define a new genapic subarch that
you only enable when you detect cpuhotplug support at boot.


Again just commenting on the text, not patch sorry.

-Andi
