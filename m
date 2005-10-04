Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbVJEAl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbVJEAl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 20:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVJEAl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 20:41:56 -0400
Received: from codepoet.org ([166.70.99.138]:42902 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S965051AbVJEAlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 20:41:55 -0400
Date: Tue, 4 Oct 2005 17:43:24 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ide-cd mini cleanup of casts (mainly)
Message-ID: <20051004234323.GA7045@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Jesper Juhl <jesper.juhl@gmail.com>, Jens Axboe <axboe@suse.de>,
	Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
References: <200510040017.57168.jesper.juhl@gmail.com> <9a8748490510031557q26f41f78s84ad936d9e78756c@mail.gmail.com> <20051004062146.GD3511@suse.de> <200510050019.44256.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510050019.44256.jesper.juhl@gmail.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 05, 2005 at 12:19:43AM +0200, Jesper Juhl wrote:
> On Tuesday 04 October 2005 08:21, Jens Axboe wrote:
> [snip]
> > This is a mess. So NACK on this patch. And why are you changing the
> [snip]
> 
> Hi Jens,
> 
> Sorry about the messy previous patch.  Would you consider something like the
> one below instead?  It only makes a few changes, not lots of different ones in
> the same patch and it also only makes changes that I hope you'll agree are 
> useful. :)
> 
> 
> Remove some unneeded casts.
> Avoid an assignment in the case of kmalloc failure.
> Break a few instances of  if (foo) whatever;  into two lines.

Revised patch looks ok to me.  I stopped maintaining this
code years ago, but since I was CC'd...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
