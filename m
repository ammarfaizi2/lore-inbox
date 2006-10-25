Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWJYWHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWJYWHE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 18:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWJYWHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 18:07:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751711AbWJYWHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 18:07:03 -0400
Date: Wed, 25 Oct 2006 15:06:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Git training wheels for the pimple faced maintainer
Message-Id: <20061025150622.1fea8f5b.akpm@osdl.org>
In-Reply-To: <453FDC13.60409@drzeus.cx>
References: <4537EB67.8030208@drzeus.cx>
	<20061019152503.217a82aa.akpm@osdl.org>
	<45386C29.7050501@drzeus.cx>
	<20061019233708.3b1f4811.akpm@osdl.org>
	<453FDC13.60409@drzeus.cx>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 25 Oct 2006 23:50:11 +0200 Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> Andrew Morton wrote:
> > I don't care what the history is.  I fetch the whole thing then generate
> > (you - linus) as a single unified diff then whack it into the patch pile.
> >   
> 
> How do you handle when I'm a bit after Linus (which will be the case
> most of the time)? Will me doing pulls left and right distrupt this?
> 

Nope, that's fine.  git gives me a diff which is "things which are in Pierre's
tree but which aren't in Linus's".

Just go ahead and do whatever it is you want to do and don't bother about
-mm.  If something goes badly wrong (it probably won't) then we can take a
look at it.
