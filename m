Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTIRPEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 11:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTIRPEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 11:04:49 -0400
Received: from holomorphy.com ([66.224.33.161]:13016 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261506AbTIRPEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 11:04:48 -0400
Date: Thu, 18 Sep 2003 08:05:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Olivier Galibert <galibert@limsi.fr>,
       Stephan von Krawczynski <skraw@ithnet.com>, neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030918150518.GZ4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jens Axboe <axboe@suse.de>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Olivier Galibert <galibert@limsi.fr>,
	Stephan von Krawczynski <skraw@ithnet.com>, neilb@cse.unsw.edu.au,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030917191946.GQ906@suse.de> <Pine.LNX.4.44.0309171629520.3994-100000@logos.cnet> <20030918070845.GS906@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030918070845.GS906@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17 2003, Marcelo Tosatti wrote:
>> IMO such GFP_DMA32 flag is a bit intrusive for 2.4, isnt it?

On Thu, Sep 18, 2003 at 09:08:45AM +0200, Jens Axboe wrote:
> Not really, it's just an extra zone. Maybe I can dig such a patch up, I
> had one for 2.4.2-pre something...

On Wed, Sep 17 2003, Marcelo Tosatti wrote:
>> What has been done in 2.6 in respect to the excessive normal zone 
>> pressure and bounce buffering problems? 

On Thu, Sep 18, 2003 at 09:08:45AM +0200, Jens Axboe wrote:
> Nothing, afaic. 2.6 isn't even completely deadlock free when it comes to
> bounce buffering.

It'd be great to have ZONE_DMA32 around for 2.6.


-- wli
