Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbUKXKm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbUKXKm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUKXKlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:41:06 -0500
Received: from zeus.kernel.org ([204.152.189.113]:7107 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262606AbUKXKkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:40:06 -0500
Date: Tue, 23 Nov 2004 22:49:30 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, colin@colino.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-ID: <20041124064930.GE2460@waste.org>
References: <20041118194959.3f1a3c8e.colin@colino.net> <87653wxqij.fsf@devron.myhome.or.jp> <20041124032017.GG8040@waste.org> <87pt237se1.fsf@devron.myhome.or.jp> <20041124053552.GD2460@waste.org> <871xejvk3l.fsf@devron.myhome.or.jp> <20041123224002.54a0e1e6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123224002.54a0e1e6.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 10:40:02PM -0800, Andrew Morton wrote:
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> >
> > AFAIK, EXT2 doesn't update all metadata synchronously in sync-mode.
> 
> It does.
> 
> I'm actually surprised to discover that [v]fat doesn't support `-o sync'. 
> It's probably a quite practical way of handling these various hotpluggable
> gadgets and would be a popular addition.
> 
> It does have the downside that it'll teach our users bad practices....

Dunno. Right now they'll still probably have an occassional kernel
crash to contend with from device disappearing from under an fs, but
at least they won't have lost all the photos on their camera...

-- 
Mathematics is the supreme nostalgia of our time.
