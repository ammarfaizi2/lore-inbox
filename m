Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVAHCny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVAHCny (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 21:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVAHCny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 21:43:54 -0500
Received: from mproxy.gmail.com ([216.239.56.250]:44115 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261644AbVAHCnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 21:43:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Ts+hlSsMvkTgqtEr1QHgkLLA4KWq6fv3sxn/l2UsogQ1aPoYUzp8/fIGPjK1HY4m7JuFUpWW7cpNw/twBOSv9F8xcTXa5AXSVISHO17Z9eUU0jkFGtJCMRlWC8PAgbtD+VPuroMY39nkA7Wk6rc5SeLaXh1/3FoV5XWG7NA+3Sw=
Message-ID: <21d7e99705010718435695f837@mail.gmail.com>
Date: Sat, 8 Jan 2005 13:43:48 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Benoit Boissinot <bboissin@gmail.com>
Subject: Re: 2.6.10-mm2
Cc: Andrew Morton <akpm@osdl.org>, Mike Werner <werner@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40f323d005010701395a2f8d00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <40f323d005010701395a2f8d00@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When i launch neverball (3d games), X get killed and I have the
> following error in dmesg (3d card 9200SE, xserver : Xorg) :
> 
> [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> 
> [drm:drm_unlock] *ERROR* Process 10657 using kernel context 0
> 

this looks like the agp backend isn't loading, Mike sent me parts of
your .config but I lost the mail (don't drink and read e-mail...)

make sure that the correct backend for your chipset is loaded (throw a
complete dmesg my way if you could.... I broke with tradition and
actually tested -mm2 on my own machine there now and I have a Radeon
9200 on an intel agp ...

Dave.
