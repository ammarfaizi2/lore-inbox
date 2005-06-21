Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVFUTnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVFUTnN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVFUTme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:42:34 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:22992 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S262265AbVFUTmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:42:01 -0400
Date: Tue, 21 Jun 2005 12:41:49 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-Id: <20050621124149.5f861518.rdunlap@xenotime.net>
In-Reply-To: <42B831B4.9020603@pobox.com>
References: <20050620235458.5b437274.akpm@osdl.org>
	<42B831B4.9020603@pobox.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005 11:26:44 -0400 Jeff Garzik wrote:

| Andrew Morton wrote:
| 
| > connector.patch
| > 
| >     Nice idea IMO, but there are still questions around the
| >     implementation.  More dialogue needed ;)
| > 
| > connector-add-a-fork-connector.patch
| > 
| >     OK, but needs connector.
| 
| I don't like connector

can you be more specific, like you did with reiser4?


| > kexec and kdump
| > 
| >     I guess we should merge these.
| > 
| >     I'm still concerned that the various device shutdown problems will
| >     mean that the success rate for crashing kernels is not high enough for
| >     kdump to be considered a success.  In which case in six months time we'll
| >     hear rumours about vendors shipping wholly different crashdump
| >     implementations, which would be quite bad.
| > 
| >     But I think this has gone as far as it can go in -mm, so it's a bit of
| >     a punt.
| 
| I'm not particularly pleased with these, and indeed vendors ARE shipping 
| other crashdump methods.

any specifics on the "not particularly pleased" part?

| > reiser4
| > 
| >     Merge it, I guess.
| > 
| >     The patches still contain all the reiser4-specific namespace
| >     enhancements, only it is disabled, so it is effectively dead code.  Maybe
| >     we should ask that it actually be removed?
| 
| The plugin stuff is crap.  This is not a filesystem but a filesystem + 
| new layer.  IMO considered in that light, it duplicates functionality 
| elsewhere.

I don't think that r4 is just a filesystem either, but you know more
about that than I do.


thanks,
---
~Randy
