Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUI0Myu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUI0Myu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 08:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUI0Myu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 08:54:50 -0400
Received: from gate.in-addr.de ([212.8.193.158]:53446 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S264396AbUI0Mys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 08:54:48 -0400
Date: Mon, 27 Sep 2004 14:54:41 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thomas Habets <thomas@habets.pp.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Message-ID: <20040927125441.GG3934@marowsky-bree.de>
References: <200409230123.30858.thomas@habets.pp.se> <20040923234520.GA7303@pclin040.win.tue.nl> <1096031971.9791.26.camel@localhost.localdomain> <200409242158.40054.thomas@habets.pp.se> <1096060549.10797.10.camel@localhost.localdomain> <20040927104120.GA30364@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927104120.GA30364@logos.cnet>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-09-27T07:41:20,
   Marcelo Tosatti <marcelo.tosatti@cyclades.com> said:

> BTW,I think a lot of applications do not gracefully handle -ENOMEM?
> 
> I suppose most of them just fail and bailout with -ENOMEM.
> 
> No?

True enough. Most of them don't even handle malloc() returning NULL.
That be their problem, though.


