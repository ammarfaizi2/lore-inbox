Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbUKEH1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbUKEH1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 02:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbUKEH1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 02:27:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11710 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262622AbUKEH1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 02:27:17 -0500
Message-ID: <418B2B48.3050707@pobox.com>
Date: Fri, 05 Nov 2004 02:27:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
References: <41877751.502@wasp.net.au>	 <1099413424.7582.5.camel@lade.trondhjem.org>  <4187E4E1.5080304@pobox.com>	 <1099431364.7854.17.camel@lade.trondhjem.org>  <418AEC14.3040605@pobox.com> <1099624193.25951.17.camel@lade.trondhjem.org>
In-Reply-To: <1099624193.25951.17.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> to den 04.11.2004 Klokka 21:57 (-0500) skreiv Jeff Garzik:
> 
> 
>>Not saying that the client is _generating_ the stale filehandle errors, 
>>only saying that they appear to go away when I boot the _client_ into 
>>older 2.6.9 kernels.
> 
> 
> That would point to some pretty nasty memory corruption issues on the
> client then (affecting the cached filehandle in the inode itself).
> 
> So... I can't see that any NFS client changes have been pushed to Linus
> after the release of 2.6.9-rc2. Is the latter afflicted with the ESTALE
> problem?

I'll give it a test and find out...

	Jeff



