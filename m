Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268271AbUHFUMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268271AbUHFUMl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268264AbUHFULc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:11:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51853 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268271AbUHFUK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:10:56 -0400
Date: Fri, 6 Aug 2004 13:10:47 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Olaf Hering <olh@suse.de>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, spot@redhat.com,
       akpm@osdl.org, zaitcev@redhat.com
Subject: Re: Make MAX_INIT_ARGS 25
Message-Id: <20040806131047.4a2c7b30@lembas.zaitcev.lan>
In-Reply-To: <20040805161236.GD26568@suse.de>
References: <20040804193243.36009baa@lembas.zaitcev.lan>
	<20040805143933.GA19219@suse.de>
	<20040805090843.5eaeed43.pj@sgi.com>
	<20040805161236.GD26568@suse.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004 18:12:36 +0200
Olaf Hering <olh@suse.de> wrote:

>  On Thu, Aug 05, Paul Jackson wrote:
> 
> > > Can the whole thing be dynamic?
> > 
> > We're a little short of dynamic memory allocation mechanisms
> > this early in the boot, I'm afraid.
> 
> Ok, I'm fine with 32, we have such a patch since ages.

I certainly don't mind 32, if SuSE software needs that. We shipped 25
for a while and everything worked on our side, so I wasn't aware.
In actuality, Mike McLean's patch did establish 32, but then it
looked like a knee-jerk power of 2 alignment, which we C hackers love
irrationally :-)

-- Pete
