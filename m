Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUKEC5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUKEC5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUKEC5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:57:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43178 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262574AbUKEC5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:57:38 -0500
Message-ID: <418AEC14.3040605@pobox.com>
Date: Thu, 04 Nov 2004 21:57:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
References: <41877751.502@wasp.net.au>	 <1099413424.7582.5.camel@lade.trondhjem.org>  <4187E4E1.5080304@pobox.com> <1099431364.7854.17.camel@lade.trondhjem.org>
In-Reply-To: <1099431364.7854.17.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> ty den 02.11.2004 Klokka 14:49 (-0500) skreiv Jeff Garzik:
> 
> 
>>This is readily reproducible with rsync -- I just boot to an earlier 
>>version of the kernel on the NFS client, and the stale filehandle 
>>problems go away.
> 
> 
> Huh? The client cannot generate stale filehandle errors: only the server
> does that.

Not saying that the client is _generating_ the stale filehandle errors, 
only saying that they appear to go away when I boot the _client_ into 
older 2.6.9 kernels.


> Have you got a binary tcpdump that shows the problem?

I'll create one if I get time and can reliably reproduce it (rsync 
_sometimes_ shows the behavior, but not always).

	Jeff


