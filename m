Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbUKECs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbUKECs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbUKECs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:48:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56745 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262575AbUKECsL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:48:11 -0500
Message-ID: <418AE9DD.3010008@pobox.com>
Date: Thu, 04 Nov 2004 21:47:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakob Oestergaard <jakob@unthought.net>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
References: <41877751.502@wasp.net.au> <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com> <20041102200925.GA12752@unthought.net>
In-Reply-To: <20041102200925.GA12752@unthought.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard wrote:
> On Tue, Nov 02, 2004 at 02:49:53PM -0500, Jeff Garzik wrote:
> 
>>Trond Myklebust wrote:
> 
> ...
> 
>>> http://nfs.sourceforge.net/nfs-howto/server.html#CONFIG
>>
>>
>>I'm also seeing stale filehandle problems here in recent kernels.
>>
>>Setup:  x86 or x86-64, TCP, NFSv4 compiled in to both server and client, 
>>but not specified in mount options.
>>
>>This is readily reproducible with rsync -- I just boot to an earlier 
>>version of the kernel on the NFS client, and the stale filehandle 
>>problems go away.
> 
> 
> Hi Jeff,
> 
> Does running an 'ls' on the server in the exported directory that is
> stale on the client resolve the problem (temporarily)?

Yes.

	Jeff



