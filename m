Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVBMNbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVBMNbN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 08:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVBMNbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 08:31:13 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:26799 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261171AbVBMNbL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 08:31:11 -0500
Date: Sun, 13 Feb 2005 14:28:33 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.11-rc4
Message-ID: <20050213132833.GA28883@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.58.0502121928590.19649@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502121928590.19649@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> :
[...]
> this is hopefully the last -rc kernel before the real 2.6.11, so please 
> give it a whirl, and complain loudly about anything broken.

- dscc4 (patch in Jeff's -netdev)
  Apart the fact that the driver crashes on module insertion and is
  unusable, users do not complain so this is a minor annoyance from
  a maintainer's pov :o)
 
- r8169 (patches available on netdev, sent to Jeff and Andrew)
  rtl8169_open() after rtl8169_close() sucks.

--
Ueimor
