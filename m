Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWGGOFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWGGOFr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 10:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWGGOFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 10:05:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49248 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751212AbWGGOFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 10:05:45 -0400
Date: Fri, 7 Jul 2006 16:08:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <mtk-manpages@gmx.net>
Cc: michael.kerrisk@gmx.net, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: splice/tee bugs?
Message-ID: <20060707140809.GC4188@suse.de>
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707114235.243260@gmx.net> <20060707120333.GR4188@suse.de> <20060707122850.GU4188@suse.de> <20060707123110.64140@gmx.net> <20060707124105.GW4188@suse.de> <20060707131247.GX4188@suse.de> <20060707140506.109310@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707140506.109310@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07 2006, Michael Kerrisk wrote:
> Jens, thep atch does not compile...
> 
> CC      fs/splice.o
> fs/splice.c: In function 'link_pipe':
> fs/splice.c:1448: error: expected 'while' before 'mutex_unlock'
> make[1]: *** [fs/splice.o] Error 1
> make: *** [fs] Error 2

Woops, missing an ending while (0); I'll send out a new one, I need to
be happy with it first...

-- 
Jens Axboe

