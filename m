Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWCXTHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWCXTHP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWCXTHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:07:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30188 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964784AbWCXTHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:07:13 -0500
Date: Fri, 24 Mar 2006 11:00:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: tilman@imap.cc, adaplas@pol.net, linux-kernel@vger.kernel.org
Subject: Re: i810 framebuffer - BUG: sleeping function called from invalid
 context
Message-Id: <20060324110028.0fdf4027.akpm@osdl.org>
In-Reply-To: <20060324150835.GD22727@stusta.de>
References: <44186D30.4040603@imap.cc>
	<20060317031410.2479d8e1.akpm@osdl.org>
	<441ACCD5.6070404@pol.net>
	<441BEF7D.4000605@imap.cc>
	<20060324150835.GD22727@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Sat, Mar 18, 2006 at 12:31:09PM +0100, Tilman Schmidt wrote:
> > On 17.03.2006 15:51, Antonino A. Daplas wrote:
> > > The console cursor can be called in atomic context.  Change memory
> > > allocation to use the GFP_ATOMIC flag in i810fb_cursor().
> > 
> > Thanks, that fixed it.
> 
> Tony, this seems to be 2.6.16.1 material?
> If yes, can you submit it for -stable?
> 

I did that.
