Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266693AbTAOQDm>; Wed, 15 Jan 2003 11:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbTAOQDm>; Wed, 15 Jan 2003 11:03:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9872 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266693AbTAOQDl>;
	Wed, 15 Jan 2003 11:03:41 -0500
Date: Wed, 15 Jan 2003 17:12:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>, Padraig@Linux.ie
Cc: Larry.Sendlosky@storigen.com, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: VIA C3 and random SIGTRAP or segfault
Message-ID: <20030115161230.GB1713@suse.de>
References: <7BFCE5F1EF28D64198522688F5449D5AC63352@xchangeserver2.storigen.com> <3E257488.3000006@Linux.ie> <200301151556.h0FFupx12324@duna48.eth.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301151556.h0FFupx12324@duna48.eth.ericsson.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15 2003, Miklos Szeredi wrote:
> 
> > segfault is what I saw. Something seems to be corrupted (by a cmov
> > SIGILL?) and from then the app will crash in the same
> > (arbitrary) place until the machine is restarted. Some apps
> > are more susceptible than others. Note a Samuel II would work fine?
> 
> Do you mean that after a cmov is encountered other applications will
> also randomly crash?  That would explain what I've been seeing.

No, it will SIGILL immediately.

-- 
Jens Axboe

