Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbSLISSY>; Mon, 9 Dec 2002 13:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266173AbSLISSY>; Mon, 9 Dec 2002 13:18:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4882 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266161AbSLISSY>; Mon, 9 Dec 2002 13:18:24 -0500
Date: Mon, 9 Dec 2002 19:26:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: #! incompatible -- binfmt_script.c broken?
Message-ID: <20021209182605.GA22747@atrey.karlin.mff.cuni.cz>
References: <9633612287A@vcnet.vc.cvut.cz> <aslmtl_im_1@cesium.transmeta.com> <20021206090234.GA1940@zaurus> <3DF4DEC0.3030800@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF4DEC0.3030800@zytor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Why can't we simply have /bin/bash_that_splits_args_itself
> 
> We could, but it would in practice mean doing an extra exec() for each
> executable.  This seems undesirable.

Only for executables that need argument spliting... For such scripts I
guess we can get handle the overhead.

								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
