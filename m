Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265945AbSKBMBX>; Sat, 2 Nov 2002 07:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265946AbSKBMBW>; Sat, 2 Nov 2002 07:01:22 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:19408 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S265945AbSKBMBV>; Sat, 2 Nov 2002 07:01:21 -0500
Date: Sat, 02 Nov 2002 06:07:17 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
Cc: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3DC3A9C0.7979C276@digeo.com>
References: <20021102025838.220E.AT541@columbia.edu> <3DC3A9C0.7979C276@digeo.com>
Message-Id: <20021102060423.032A.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop015.verizon.net from [138.89.32.225] at Sat, 2 Nov 2002 06:07:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Nov 2002 02:32:32 -0800
Andrew Morton <akpm@digeo.com> mentioned:

> Akira Tsukamoto wrote:
> > 
> But you've inlined them again.  Your patches increase my kernel
> size by 17 kbytes, which is larger than my entire Layer 1 instruction
> cache!

It is because I was working on this patch based on 2.5.44 :)

As Andi mentioned, how about selecting if OCNFIG_SAMLL is defined?


