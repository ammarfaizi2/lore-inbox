Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUHBWF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUHBWF3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUHBWF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:05:29 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:31152 "EHLO
	puzzle.pobox.com") by vger.kernel.org with ESMTP id S264147AbUHBWFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:05:25 -0400
Date: Mon, 2 Aug 2004 15:05:21 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Steve Snyder <swsnyder@insightbb.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Message-ID: <20040802220521.GA2179@ip68-4-98-123.oc.oc.cox.net>
References: <200408021602.34320.swsnyder@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408021602.34320.swsnyder@insightbb.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 04:02:34PM -0500, Steve Snyder wrote:
> There seems to be a controversy about the use of the CONFIG_HIGHMEM4G  
> kernel configuration.  After reading many posts on the subject, I still 
> don't know which setting is best for me.

On my own desktop system with 1GB RAM, any highmem slowdown seems to be
outweighed by the fact that more disk data stays cached in RAM (so I hit
the disk much less often).

Everyone else I know has also found the extra RAM to greatly outweigh
the highmem slowdown, although those people are running clusters &
servers, not desktops, with this much RAM.

-Barry K. Nathan <barryn@pobox.com>
