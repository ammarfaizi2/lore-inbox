Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbSLGSnJ>; Sat, 7 Dec 2002 13:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbSLGSnJ>; Sat, 7 Dec 2002 13:43:09 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:43273 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S264657AbSLGSnI>; Sat, 7 Dec 2002 13:43:08 -0500
Subject: Re: Re[2]: [STATUS] fbdev api.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Tobias Rittweiler <inkognito.anonym@uni.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0212071058230.8383-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0212071058230.8383-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 02:43:33 +0500
Message-Id: <1039297451.1026.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 00:05, James Simmons wrote:
[...]
> Most of those fixes I already have in BK. I think yres_virtual being
> set to -1 is wrong. Also do we really need to call check var? The default
> mode is "trusted". Also fb_find_mode when we use it calls check_var.
> default_var already has the correct virtual res info. We do need to set
> fix tho :-)  Thanks for the fixes.
> 
That's okay James, the code that calls check_var() during init  is a
"temporary" code.  Rivafb happens to have a do_maximize() function that
computes for the highest yres_virtual when it's -1.  Currently, since
using fbset is broken, I do that to enable ypanning.  But it's not
important.

Tony


