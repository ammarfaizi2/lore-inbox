Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUD2Chn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUD2Chn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbUD2Chm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:37:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:26545 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262434AbUD2Chi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:37:38 -0400
Date: Wed, 28 Apr 2004 19:35:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marc Singer <elf@buici.com>
Cc: riel@redhat.com, brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040428193541.1e2cf489.akpm@osdl.org>
In-Reply-To: <20040429022944.GA24000@buici.com>
References: <20040428180038.73a38683.akpm@osdl.org>
	<Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com>
	<20040428185720.07a3da4d.akpm@osdl.org>
	<20040429022944.GA24000@buici.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer <elf@buici.com> wrote:
>
> On Wed, Apr 28, 2004 at 06:57:20PM -0700, Andrew Morton wrote:
> > Rik van Riel <riel@redhat.com> wrote:
> > >
> > >  IMHO, the VM on a desktop system really should be optimised to
> > >  have the best interactive behaviour, meaning decent latency
> > >  when switching applications.
> > 
> > I'm gonna stick my fingers in my ears and sing "la la la" until people tell
> > me "I set swappiness to zero and it didn't do what I wanted it to do".
> 
> It does, but it's a bit too coarse of a solution.  It just means that
> the page cache always loses.

That's what people have been asking for.  What are you suggesting should
happen instead?

