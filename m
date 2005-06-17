Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVFQNm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVFQNm1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVFQNm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:42:27 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:14853 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261972AbVFQNmS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:42:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l+ENK5NxatSHiwMzKcG2oDVz3kqFA5seCW3nigKQ0ehkCQV6d4wGngMhxY4PzKDJKAYu96yMg/cmqJAWQkw34HTkmqh6ESCa1upS4L+piQJl8lAgFQREoJIQpzpNg4z7NXamfBI62Wsx8A7KeFgmDdFhzwiLmO6lhL9+EFlyVNI=
Message-ID: <377362e105061706426683ee01@mail.gmail.com>
Date: Fri, 17 Jun 2005 22:42:17 +0900
From: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
Reply-To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Need to hack kernel module of VTune (remap_page_range)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to install VTune by Intel (see
http://www.intel.com/software/products/vtune/vlin/index.htm for
details) but this creates a kernel module for "older" kernels; it can
be built on my Gentoo w/kernel 2.6.11.12, but it looks for symbol
"remap_page_range" which was used until 2.6.8 or 2.6.9.  So I would
like to know how to hack this kernel module (fortunately sources are
with the package).   What's the key?

It's defined in linux/mm/nommu.c in kernel-2.6.9.

Thanks in advance!!
-- 
Luckiest in the world / Weapon of Mass Distraction
http://maverick6664.bravehost.com/
Aviation Jokes: http://www.geocities.com/tetsuji_rai/
Background: http://maverick.ns1.name/
