Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSKCDvy>; Sat, 2 Nov 2002 22:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbSKCDvy>; Sat, 2 Nov 2002 22:51:54 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:2793 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S261587AbSKCDvx>; Sat, 2 Nov 2002 22:51:53 -0500
Date: Sat, 02 Nov 2002 21:57:49 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
Cc: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3DC3A9C0.7979C276@digeo.com>
References: <20021102025838.220E.AT541@columbia.edu> <3DC3A9C0.7979C276@digeo.com>
Message-Id: <20021102214537.379A.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at out002.verizon.net from [138.89.32.225] at Sat, 2 Nov 2002 21:58:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Nov 2002 02:32:32 -0800
Andrew Morton <akpm@digeo.com> mentioned:
> I'd prefer that we have these functions in .c, and laid out with
> a minimum of C tricks.  Because more work needs to be done on the
> memory copy functions, and doing that in header files is a pain.

Personally I don't mind adding everything in .h or .c.
I just used the convention what string.h and string-486.h doing.
Isn't it confusing that adding everything in .c also?


