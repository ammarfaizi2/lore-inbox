Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWH3SPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWH3SPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWH3SPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:15:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:11667 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750763AbWH3SO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:14:59 -0400
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] re-add -ffreestanding
Date: Wed, 30 Aug 2006 20:13:58 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
References: <20060830175727.GI18276@stusta.de>
In-Reply-To: <20060830175727.GI18276@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608302013.58122.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 19:57, Adrian Bunk wrote:
> I got the following compile error with gcc 4.1.1 when trying to compile 
> kernel 2.6.18-rc4-mm2 for m68k:

If anything then -ffreestanding needs to be added to arch/m68k/Makefile
(assuming it doesn't compile at all right now)

-Andi
