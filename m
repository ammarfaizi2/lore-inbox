Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVBZBJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVBZBJk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 20:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVBZBIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 20:08:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:46539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262798AbVBZBD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 20:03:28 -0500
Date: Fri, 25 Feb 2005 17:04:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olh@suse.de>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.11-rc5
In-Reply-To: <20050226005321.GA26468@suse.de>
Message-ID: <Pine.LNX.4.58.0502251657220.9237@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
 <20050224145049.GA21313@suse.de> <20050226004137.GA25539@suse.de>
 <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org> <20050226005321.GA26468@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Feb 2005, Olaf Hering wrote:
> 
> sparse doesnt do that, yet? (I never looked at it.)

No, it doesn't look at the section info. I guess I could do it, but there 
_is_ a "make buildcheck" which does it based on perl stuff and the link 
information. 

And I can do "make buildcheck" myself, but some people have done it before
and know which ones are false positives etc, so I was hoping..

Hint hint, wherever you are..

		Linus
