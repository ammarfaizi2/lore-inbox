Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVAHPli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVAHPli (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 10:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVAHPlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 10:41:37 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:57840 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261191AbVAHPlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 10:41:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IH2LYyeLi1XH8N5B35oOBmb0LjuVEPmkkAs6cmFrPT7y7y/fk+quGzzMaWmSY9VIZNIXmg1+lNBB7KZ6VpFjGVf+zMYEL8dfNGGUHduKw8xfMD/103lDV4FmAwosWwDW9cJjokmRvtK4J+51VPcmu9+VyTGCPhAav6A09TCVKxo=
Message-ID: <40f323d0050108074112ae4ac7@mail.gmail.com>
Date: Sat, 8 Jan 2005 16:41:14 +0100
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.10-mm2
Cc: Andrew Morton <akpm@osdl.org>, Mike Werner <werner@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <21d7e99705010805487322533e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <40f323d005010701395a2f8d00@mail.gmail.com>
	 <21d7e99705010718435695f837@mail.gmail.com>
	 <40f323d00501080427f881c68@mail.gmail.com>
	 <21d7e99705010805487322533e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2005 00:48:56 +1100, Dave Airlie <airlied@gmail.com> wrote:
> >
> > if you look at the .config, agp and agp_via are not build as modules.
> >
> 
> can you also try a build with vesafb turned off? I'm just wondering is
> there maybe a resource conflict or something like that going on ...
> 
> Dave.
> 

Removing the framebuffer from the boot command line solved it... (with
the patch that Mike Werner posted ; without it, it oopsed).

Benoit.
