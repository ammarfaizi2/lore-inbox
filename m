Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbVIAVOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbVIAVOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVIAVOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:14:35 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:50348 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1030383AbVIAVOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:14:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm1: PCMCIA problem
Date: Thu, 1 Sep 2005 23:14:48 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050901035542.1c621af6.akpm@osdl.org>
In-Reply-To: <20050901035542.1c621af6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509012314.48434.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 1 of September 2005 12:55, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/

I cannot start PCMCIA on x86-64 SuSE 9.3 on Asus L5D.  Apparently, the following
command:

sh -c modprobe --ignore-install firmware_class; echo 30 > /sys/class/firmware/timeout

loops forever with almost 100% of the time spent in the kernel.

AFAICS, 2.6.13-rc6-mm2 is also affected, but the mainline kernels are not.

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
