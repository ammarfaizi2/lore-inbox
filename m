Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266841AbTGKVkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbTGKVkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:40:41 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:46247 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S266841AbTGKVkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:40:40 -0400
Date: Fri, 11 Jul 2003 23:55:30 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, xose@wanadoo.es
Subject: Re: is lvm stuck in 2.4 ?
Message-ID: <20030711215530.GA26999@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, xose@wanadoo.es
References: <3F0F0746.8060403@wanadoo.es> <20030711195737.GC976@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030711195737.GC976@matchmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 12:57:37PM -0700, Mike Fedyk wrote:
> On Fri, Jul 11, 2003 at 08:51:50PM +0200, Xose Vazquez Perez wrote:
> > 
> > kernel has version 1.0.5+ (22/07/2002), but latest
> > is 1.0.7(2003/03/03). Is there any problem with 1.0.7 and
> > 2.4 ?
> 
> Most likely not.  It probably hasn't been merged yet.
> 
> As well as the vfs patch needed for the journaled filesystems (forgot the
> name).
> 
> Are there any efforts to get this merged?

if it is useful, here is a patch for 1.0.7 for the 2.4 kernel ...
I just verified, that it applies without any issues on 
2.4.22-pre5 and it was tested on 2.4.21-pre5, 2.4.21, 
2.4.22-pre1, and  2.4.22-pre3 ...

http://www.13thfloor.at/VServer/patches-2.4.22-p3c17/07_lvm-1.0.7-2.4.21pre5.patch.bz2

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
