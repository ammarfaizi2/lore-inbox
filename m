Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTLQHfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 02:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTLQHft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 02:35:49 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:10455 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263771AbTLQHft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 02:35:49 -0500
Date: Wed, 17 Dec 2003 08:35:47 +0100
From: bert hubert <ahu@ds9a.nl>
To: "Daniel Richard G." <skunk@iskunk.org>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, torvalds@osdl.org
Subject: Re: [PATCH] include/asm-i386/byteorder.h: ANSI mode fixes
Message-ID: <20031217073547.GA5042@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"Daniel Richard G." <skunk@iskunk.org>, linux-kernel@vger.kernel.org,
	marcelo@conectiva.com.br, torvalds@osdl.org
References: <20031217071829.GA30851@midnight>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217071829.GA30851@midnight>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 02:18:29AM -0500, Daniel Richard G. wrote:
> This header file uses `inline' where it should use `__inline__', `asm'
> where it should use `__asm__'. GCC with -ansi barfs if it sees these
> keywords without the double underscores. Headaches for the KDE folks:

The kernel is not written in 'ansi C' but in gcc, mostly - not sure if you
should expect kernel headers to function with -ansi.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
