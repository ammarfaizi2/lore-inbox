Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTDJGIh (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 02:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTDJGIh (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 02:08:37 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:6928 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263897AbTDJGIh (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 02:08:37 -0400
Date: Thu, 10 Apr 2003 07:20:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] couple of megaraid fixes
Message-ID: <20030410072015.A15397@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, davidm@hpl.hp.com,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <200304092258.h39Mw2Di011866@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304092258.h39Mw2Di011866@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Wed, Apr 09, 2003 at 03:58:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 03:58:02PM -0700, David Mosberger wrote:
> The attached patch has been in my tree for some time.  IIRC, Grant
> Grundler sent it to me.  The old code is clearly broken: it still uses
> virt_to_bus() and SCpnt->pid is declared as "unsigned long", so I'm
> pretty sure this is an improvement. ;-)

Looks okay, but I really wonder where the promised complete rewrite
(megaraid2) is stuck..

