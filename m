Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262369AbSI2CGT>; Sat, 28 Sep 2002 22:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbSI2CGT>; Sat, 28 Sep 2002 22:06:19 -0400
Received: from bitchcake.off.net ([216.138.242.5]:30374 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S262369AbSI2CGT>;
	Sat, 28 Sep 2002 22:06:19 -0400
Date: Sat, 28 Sep 2002 22:11:41 -0400
From: Zach Brown <zab@zabbo.net>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: suspect list_empty( {NULL, NULL} )
Message-ID: <20020928221141.E13817@bitchcake.off.net>
References: <20020928205836.C13817@bitchcake.off.net> <3D96580D.A0F803BC@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D96580D.A0F803BC@digeo.com>; from akpm@digeo.com on Sat, Sep 28, 2002 at 06:31:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > $22 = {host = 0xc03b6e00
> 
> That's swapper_space.

ah, of course.  that does seem to fix it, thanks.
