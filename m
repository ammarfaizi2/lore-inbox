Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbUKBUnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUKBUnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 15:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUKBUnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 15:43:03 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:42647 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261366AbUKBUm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 15:42:59 -0500
Message-ID: <4187F69E.9020604@drdos.com>
Date: Tue, 02 Nov 2004 14:05:34 -0700
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
References: <41877751.502@wasp.net.au> <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com>
In-Reply-To: <4187E4E1.5080304@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>
> I'm also seeing stale filehandle problems here in recent kernels.
>
> Setup: x86 or x86-64, TCP, NFSv4 compiled in to both server and 
> client, but not specified in mount options.
>
> This is readily reproducible with rsync -- I just boot to an earlier 
> version of the kernel on the NFS client, and the stale filehandle 
> problems go away.
>
> JEff
>
>
I am seeing severe nfs problems between kernels again, 2.4 - > 2.6 -> 
2.4 V3 and V4 problems connecting and filesize mismatches between
actual/reported. Might point to where the bug is.

Jeff

