Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSKNNTq>; Thu, 14 Nov 2002 08:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSKNNTq>; Thu, 14 Nov 2002 08:19:46 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:28553 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S262452AbSKNNTn>;
	Thu, 14 Nov 2002 08:19:43 -0500
Date: Thu, 14 Nov 2002 14:26:30 +0100
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5-bk AT_GID clash
Message-ID: <20021114132630.GA11264@gagarin>
References: <20021112225022.GA10689@gagarin> <20021114054614.3120D2C158@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021114054614.3120D2C158@lists.samba.org>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 05:44:22PM +1100, Rusty Russell wrote:
> You missed the arch's module.c and the module_free function.  Does
> this work for you (untested here, snarfed off on your patch)?

Yes, works fine!

And I dont use any modules that need parameters, so the new
in-kernel-moduleloader works great for me.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
