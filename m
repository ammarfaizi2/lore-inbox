Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVEKKwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVEKKwZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 06:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVEKKwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 06:52:25 -0400
Received: from ozlabs.org ([203.10.76.45]:32445 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261204AbVEKKwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 06:52:23 -0400
Subject: Re: [PATCH] Re: [ANNOUNCE] hotplug-ng 002 release
From: Rusty Russell <rusty@rustcorp.com.au>
To: Erik van Konijnenburg <ekonijn@xs4all.nl>
Cc: Greg KH <gregkh@suse.de>, "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Roman Kagan <rkagan@mail.ru>
In-Reply-To: <20050511115955.D7594@banaan.localdomain>
References: <20050510172447.GA11263@wonderland.linux.it>
	 <20050510201355.GB3226@suse.de>
	 <20050510203156.GA14979@wonderland.linux.it>
	 <20050510205239.GA3634@suse.de>
	 <20050510210823.GB15541@wonderland.linux.it>
	 <20050510232207.A7594@banaan.localdomain>
	 <20050511015509.B7594@banaan.localdomain>
	 <1115770106.17201.21.camel@localhost.localdomain>
	 <20050511031103.C7594@banaan.localdomain>
	 <1115782753.17201.54.camel@localhost.localdomain>
	 <20050511115955.D7594@banaan.localdomain>
Content-Type: text/plain
Date: Wed, 11 May 2005 20:52:02 +1000
Message-Id: <1115808722.16408.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 11:59 +0200, Erik van Konijnenburg wrote:
> Based on comments from Greg and Christian, it would be better to apply
> blacklisting only to the result of alias expanding for kernel generated
> module maps.

Then perhaps depmod should be the one to read a blacklist file?  It
produces the modules.alias file where these things live.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

