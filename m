Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWDEAZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWDEAZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWDEAZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:25:16 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38276
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751035AbWDEAZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:25:15 -0400
Date: Tue, 04 Apr 2006 17:16:44 -0700 (PDT)
Message-Id: <20060404.171644.12655459.davem@davemloft.net>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, rdunlap@xenotime.net,
       davej@redhat.com, chuckw@quantumlinux.com, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, eugene.teo@eugeneteo.net
Subject: Re: [patch 02/26] USB: Fix irda-usb use after use
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060404235943.GC27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
	<20060404235927.GA27049@kroah.com>
	<20060404235943.GC27049@kroah.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: gregkh@suse.de
Date: Tue, 4 Apr 2006 16:59:43 -0700

> Don't read from free'd memory after calling netif_rx().  docopy is used as
> a boolean (0 and 1) so unsigned int is sufficient.
> 
> Coverity bug #928
> 
> Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>
> Cc: "David Miller" <davem@davemloft.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Signed-off-by: David S. Miller <davem@davemloft.net>

