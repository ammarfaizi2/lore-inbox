Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTGGWsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 18:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTGGWsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 18:48:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41396 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261808AbTGGWsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 18:48:18 -0400
Message-ID: <3F09FC12.4070609@pobox.com>
Date: Mon, 07 Jul 2003 19:02:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] new quota code
References: <200307072105.h67L50ir024592@hera.kernel.org>
In-Reply-To: <200307072105.h67L50ir024592@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1059, 2003/07/07 17:01:15-03:00, hch@lst.de
> 
> 	[PATCH] new quota code
> 	
> 	Okay, here's the quota patch.  Basically all changes are from Jan Kara
> 	and I backport them from 2.5.  The 32bit quota code has been shipped
> 	by the commercial vendors ever since they used Linux 2.4 and this
> 	particular codebase with backwards compatiblity support is around
> 	in the 2.5, the XFS tree, -ac and -aa for a long time.  The only
> 	change over that version is that support for the old 16bit quota
> 	format and the old quotactl ABI is enabled unconditionally, i.e.
> 	there's no way to render your system unusable by wrong make config
> 	choices [1].
> 	
> 	[1] This also mean completely dropping support for the interim ABI
> 	used in the early 32bit quota patches as it's mutally incompatible
> 	to the old ABI.  But we never ever shipped that in any mainline kernels
> 	so there's no problem.


"no problem" being defined here as "multiple vendors shipped it but I 
don't care", right?

Why do we need a third (fourth?) 2.4 quota abi/api floating around?

	Jeff



