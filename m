Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVAGBQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVAGBQs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVAGBQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:16:41 -0500
Received: from waste.org ([216.27.176.166]:49816 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261230AbVAGBNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:13:49 -0500
Date: Thu, 6 Jan 2005 17:13:09 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       ast@domdv.de, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu, joq@io.com
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107011309.GB2995@waste.org>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de> <1104898693.24187.162.camel@localhost.localdomain> <20050104215010.7f32590e.akpm@osdl.org> <20050105120601.GA8730@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105120601.GA8730@mail.13thfloor.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 01:06:02PM +0100, Herbert Poetzl wrote:
> On Tue, Jan 04, 2005 at 09:50:10PM -0800, Andrew Morton wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > >
> > >  Can we use capabilities
> > 
> > capabilities don't work :(
> > 
> > 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.0/0502.html
> 
> well, maybe it is time to fix them ..
> 
> I already proposed some methods to extend them,
> and I'm also willing to dig into the various things
> required to allow to use the capability system for
> what it was intended.

You can't fix them without changing the semantics for existing users
in ways they didn't expect. It could be done with a new personality flag,
but..

-- 
Mathematics is the supreme nostalgia of our time.
