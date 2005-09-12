Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVILWod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVILWod (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVILWod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:44:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932324AbVILWoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:44:32 -0400
Date: Mon, 12 Sep 2005 15:44:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: michal.k.k.piotrowski@gmail.com
Cc: alexn@telia.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm3 [OOPS] vfs, page_owner, full reproductively, badness
 in vsnprintf
Message-Id: <20050912154428.7026eff7.akpm@osdl.org>
In-Reply-To: <6bffcb0e05091214133c189d05@mail.gmail.com>
References: <20050912024350.60e89eb1.akpm@osdl.org>
	<6bffcb0e050912044856628995@mail.gmail.com>
	<20050912175433.GA8574@localhost.localdomain>
	<6bffcb0e05091214133c189d05@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> Hi,
> 
> On 12/09/05, Alexander Nyberg <alexn@telia.com> wrote:
> > 
> > Gah, I'm such a fantastic programmer.
> > 
> > I don't know what mc is up to but the error checking in read_page_owner
> > is flawed wrt snprintf which could cause the 'size' argument to snprintf
> > to become negative and if so overwrite beyond 'buf'.
> > 
> > Again, I fail to see how mc causes this to happen, but this fixes it
> > by proper error checking.
> > 
> > Signed-off-by: Alexander Nyberg <alexn@telia.com>
> 
> Thanks, patch solved problem.

Thanks.

> Here is version, that clean apply on 2.6.13-mm3. Can you review it?

That patch is all wordwrapped.

How doe sit differe from Alex's patch?

