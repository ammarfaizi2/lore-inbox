Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267309AbTBUApf>; Thu, 20 Feb 2003 19:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267328AbTBUApf>; Thu, 20 Feb 2003 19:45:35 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:50706 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267309AbTBUAoG>; Thu, 20 Feb 2003 19:44:06 -0500
Date: Fri, 21 Feb 2003 00:54:12 +0000
From: John Levon <levon@movementarian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add module load profile hook
Message-ID: <20030221005412.GA95016@compsoc.man.ac.uk>
References: <20030220215317.GA80769@compsoc.man.ac.uk> <20030221004042.22EC12C117@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221004042.22EC12C117@lists.samba.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18m1S8-000DBt-00*ZnGS2GeqK3M*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 11:33:46AM +1100, Rusty Russell wrote:

> Sure, but I think I prefer a more generic notifier mechanism anyway,
> which oprofile can use as well as other mechanisms.
> 
> Say, module_notifier with a MODULE_LOADED, MODULE_INITIALIZED,
> MODULE_UNLOADING, MODULE_GONE?

What needs this ?

> Thoughts?

If the code isn't going to be used there's no point in it. But if it is,
I'm fine with fitting in with the above.

regards
john
