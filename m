Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316823AbSGCDzk>; Tue, 2 Jul 2002 23:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316863AbSGCDzj>; Tue, 2 Jul 2002 23:55:39 -0400
Received: from mtiwmhc22.worldnet.att.net ([204.127.131.47]:39399 "EHLO
	mtiwmhc22.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S316823AbSGCDzj>; Tue, 2 Jul 2002 23:55:39 -0400
Date: Wed, 3 Jul 2002 00:03:01 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
Message-ID: <20020703040301.GA3233@lnuxlab.ath.cx>
References: <20020703022051.GA2669@lnuxlab.ath.cx> <3D226E86.695D27F3@zip.com.au> <20020703033538.GA3004@lnuxlab.ath.cx> <3D227621.B0A5C826@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D227621.B0A5C826@zip.com.au>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 08:57:21PM -0700, Andrew Morton wrote:
> Possibly what is happening is that the /tmp partition lies on
> a part of the disk which has a higher platter transfer speed
> and this higher speed is causing retries or other problems
> further down the chain.
> 
> You could have a fiddle with hdparm, try slowing down the
> interface speed.  Try a different set of cables, too.

Just tried with dma disabled, same problem.  I'm gonna try another IDE
controller and see if it still happens.

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
