Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbUAYWOw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbUAYWOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:14:51 -0500
Received: from colin2.muc.de ([193.149.48.15]:40969 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265289AbUAYWOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:14:51 -0500
Date: 25 Jan 2004 23:13:04 +0100
Date: Sun, 25 Jan 2004 23:13:04 +0100
From: Andi Kleen <ak@muc.de>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, bunk@fs.tum.de,
       eric@cisu.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040125221304.GD28576@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net> <200401252221.01679.cova@ferrara.linux.it> <20040125214653.GB28576@colin2.muc.de> <200401252308.33005.cova@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401252308.33005.cova@ferrara.linux.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 11:08:33PM +0100, Fabio Coatti wrote:
> > does official 2.6.2rc1 (not mm) with -funit-at-a-time enabled in the
> > Makefile work?
> 
> Yes. 

Ok, then it is something in -mm*. I would suspect the new weird CPU
configuration stuff. Can you double check you configured your CPU correctly? 
Or do you use 4/4? If yes turn that off.

-Andi
