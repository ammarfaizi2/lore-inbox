Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288964AbSATXNz>; Sun, 20 Jan 2002 18:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288966AbSATXNq>; Sun, 20 Jan 2002 18:13:46 -0500
Received: from pille1.addcom.de ([62.96.128.35]:5133 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S288964AbSATXNf>;
	Sun, 20 Jan 2002 18:13:35 -0500
Date: Mon, 21 Jan 2002 00:10:21 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Frank Davis <fdavis@si.rr.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.3-pre2: isdn_common.c compile error
In-Reply-To: <Pine.LNX.4.33.0201201644001.1213-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201210007100.1692-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002, Frank Davis wrote:

> isdn_common.c: In function `isdn_register_devfs':
> isdn_common.c:2256: `ISDN_MINOR_B' undeclared (first use in this function)
> isdn_common.c:2256: (Each undeclared identifier is reported only once
> isdn_common.c:2256: for each function it appears in.)

Thanks, I didn't test with the devfs on. Just remove the offending line 
completely. I'll send a patch to Linus.

--Kai



