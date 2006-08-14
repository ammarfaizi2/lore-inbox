Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWHNR4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWHNR4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWHNR4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:56:30 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:46237 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932383AbWHNR43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:56:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm1
Date: Mon, 14 Aug 2006 19:54:29 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org>
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608141954.29656.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 10:24, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> 

This patch:

simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch

makes my x86_64 SMP box (dual-core Athlon 64 on an ULi-based AsRock mobo) run
_very_ slow (it would take tens of minutes to boot the box if I were as
patient as to wait for that).

Strangely enough, on a non-SMP box I have tested it on it works just fine.

Greetings,
Rafael
