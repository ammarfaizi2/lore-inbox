Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262515AbSI0Rxy>; Fri, 27 Sep 2002 13:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262558AbSI0Rxy>; Fri, 27 Sep 2002 13:53:54 -0400
Received: from tapu.f00f.org ([66.60.186.129]:65158 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262515AbSI0Rxx>;
	Fri, 27 Sep 2002 13:53:53 -0400
Date: Fri, 27 Sep 2002 10:59:13 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
Message-ID: <20020927175913.GC17458@tapu.f00f.org>
References: <20020927174235.GB17458@tapu.f00f.org> <Pine.LNX.4.44.0209271952540.17034-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209271952540.17034-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 07:53:23PM +0200, Ingo Molnar wrote:

> to DMA into a page that does not belong to the process anymore? I
> doubt that.

ah, ok ... sure, that isn't (shouldn't be) allowed

i was thinking of reading/writing to/from data during COW


  --cw

