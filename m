Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWA3UZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWA3UZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWA3UZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:25:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:56247 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964949AbWA3UZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:25:29 -0500
Date: Mon, 30 Jan 2006 21:25:27 +0100
From: Olaf Hering <olh@suse.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] record last user if malloc request is exact 4k
Message-ID: <20060130202527.GB12315@suse.de>
References: <20060130174919.GA7599@suse.de> <84144f020601301223j709ce2bco707ee73cf2d583b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84144f020601301223j709ce2bco707ee73cf2d583b4@mail.gmail.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jan 30, Pekka Enberg wrote:

> Hi,
> 
> On 1/30/06, Olaf Hering <olh@suse.de> wrote:
> > Is there a reason why a 4096 malloc is not recorded?
> > untested patch below.
> >
> > allow SLAB_STORE_USER also with an exact 4k request.
> 
> For architectures that have 4K pages, adding debugging overhead to 4K
> objects is pretty much the worst case. Any particular reason you want
> this?

I'm just curious.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
