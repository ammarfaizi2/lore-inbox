Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262399AbSI2GTM>; Sun, 29 Sep 2002 02:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262400AbSI2GTM>; Sun, 29 Sep 2002 02:19:12 -0400
Received: from bitchcake.off.net ([216.138.242.5]:52646 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S262399AbSI2GTL>;
	Sun, 29 Sep 2002 02:19:11 -0400
Date: Sun, 29 Sep 2002 02:24:35 -0400
From: Zach Brown <zab@zabbo.net>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.39 list_head debugging
Message-ID: <20020929022435.M13817@bitchcake.off.net>
References: <20020929015852.K13817@bitchcake.off.net> <3D9699DE.F7528065@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9699DE.F7528065@digeo.com>; from akpm@digeo.com on Sat, Sep 28, 2002 at 11:12:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could we make these just do a printk+dump_stack and continue
> on?  A BUG is a bit severe.

sure.  I was taking the overzealous avoidance of possible memory
corruption, but I'm sure you're right that its better to be a little
forgiving.  I'll fixup and resend.

- z
