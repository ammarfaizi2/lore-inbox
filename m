Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUD1WNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUD1WNo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 18:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUD1WNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 18:13:44 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:4862 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261210AbUD1WNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 18:13:43 -0400
Date: Wed, 28 Apr 2004 15:13:34 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jens Axboe <axboe@suse.de>
Cc: Kenneth Johansson <ken@kenjo.org>,
       Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] DVD writing in 2.6.6-rc2
Message-ID: <20040428221334.GA22404@taniwha.stupidest.org>
References: <1083088772.2679.11.camel@tiger> <20040427183607.GA3011@suse.de> <8n23m1-g22.ln1@legolas.mmuehlenhoff.de> <20040428113056.GA2150@suse.de> <1083176956.2679.19.camel@tiger> <20040428200953.GA3470@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428200953.GA3470@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 10:09:54PM +0200, Jens Axboe wrote:

> So it just helped me unearth a different problem :-). There
> certainly is a bug here, it looks like it's hardware though (see the
> above description). ide-cd just needs to have it's SYNC_CACHE
> retries limited, then the kernel should at least recover.

I see cache flushes also go mute and hang forwever.  I think ideally
we need to hack the IDE layer to have sane timeouts or something
perhaps?


  --cw
