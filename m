Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265094AbUGBXPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUGBXPW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 19:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265033AbUGBXPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 19:15:22 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:64179 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265094AbUGBXPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 19:15:19 -0400
Date: Sat, 3 Jul 2004 01:07:09 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: jt@hpl.hp.com
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       David Gibson <hermes@gibson.dropbear.id.au>
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current CVS
Message-ID: <20040703010709.A22334@electric-eye.fr.zoreil.com>
References: <20040702222655.GA10333@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040702222655.GA10333@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Fri, Jul 02, 2004 at 03:26:55PM -0700
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes <jt@bougret.hpl.hp.com> :
[...]
> 	The difference between 0.13e and 0.15rc1+ is not small. I
> believe Pavel did a good job in splitting the various patches in small
> pieces when adding them to the CVS, and David has tracked the kernel,
> but reconciliating the two branches is no trivial matter.

I have extracted a few things from the bz2 ball that Dan sent (against
2.6.7-mm5 which already contains some orinoco bits):

-rw-r--r--    1 romieu   users        4564 jui  3 00:47 orinoco-10.patch
-rw-r--r--    1 romieu   users       15999 jui  3 00:47 orinoco-20.patch
-rw-r--r--    1 romieu   users       33135 jui  3 00:47 orinoco-30.patch
-rw-r--r--    1 romieu   users       11463 jui  3 00:47 orinoco-40.patch

Available at http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.7-mm5/

So far the patches lack comments but they are quite simple.

--
Ueimor
