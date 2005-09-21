Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVIURbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVIURbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVIURbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:31:38 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:35548 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751299AbVIURbi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:31:38 -0400
Date: Wed, 21 Sep 2005 19:28:37 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Bgs <bgs@bgs.hu>, linux-kernel@vger.kernel.org,
       Tommy Christensen <tommy.christensen@tpack.net>
Subject: Re: probs with realtek 8110/8169 NIC
Message-ID: <20050921172837.GA28317@electric-eye.fr.zoreil.com>
References: <4331229D.9050302@bgs.hu> <43316B1F.6010106@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43316B1F.6010106@grupopie.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques <pmarques@grupopie.com> :
[...]
> I would suggest you turn CONFIG_4KSTACKS off or use a different filesystem.

This is not needed. Tommy Christensen noticed that the r8169 driver
called a forbidden function in an irq context.

I'll have to figure why it was not noticed during the last testing round
but that's a different story.

--
Ueimor
