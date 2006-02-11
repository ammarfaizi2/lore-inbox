Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWBKOkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWBKOkk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 09:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWBKOkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 09:40:39 -0500
Received: from mail22.bluewin.ch ([195.186.19.66]:41398 "EHLO
	mail22.bluewin.ch") by vger.kernel.org with ESMTP id S932262AbWBKOkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 09:40:39 -0500
Date: Sat, 11 Feb 2006 09:39:34 -0500
To: Jean Delvare <khali@linux-fr.org>
Cc: Arthur Othieno <apgo@patchbomb.org>, Andrew Morton <akpm@osdl.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] matroxfb: simply return what i2c_add_driver() does
Message-ID: <20060211143934.GC14516@krypton>
References: <11396556342192-git-send-email-apgo@patchbomb.org> <20060211145322.151f47d4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211145322.151f47d4.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
From: apgo@patchbomb.org (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 02:53:22PM +0100, Jean Delvare wrote:
> Hi Arthur,
> 
> > insmod will tell us when the module failed to load. We do no further
> > processing on the return from i2c_add_driver(), so just return what
> > i2c_add_driver() did, instead of storing it.
> > 
> > Add __init/__exit annotations while we're at it.
> > 
> > Signed-off-by: Arthur Othieno <apgo@patchbomb.org>
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> Arthur, do you have such a device yourself? I have another cleanup
> patch for this driver and am looking for testers.
 
Unfortunately not ;( This was the last of i2c_add_driver() return audit
I had sitting around. I'm sure someone with said device will speak up..
