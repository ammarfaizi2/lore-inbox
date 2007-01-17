Return-Path: <linux-kernel-owner+w=401wt.eu-S1751846AbXAQWQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbXAQWQA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbXAQWQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:16:00 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:46319 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbXAQWP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:15:59 -0500
X-Greylist: delayed 163838 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 17:15:59 EST
From: syrius.ml@no-log.org
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc5 nfs+krb => oops
Message-ID: <87y7o12tdp.87wt3l2tdp@87vej52tdp.message.id>
References: <871wlyo8fi.87zm8mmtv2@87y7o6mtv2.message.id>
	<1168950785.6072.37.camel@lade.trondhjem.org>
Date: Wed, 17 Jan 2007 23:15:57 +0100
In-Reply-To: <1168950785.6072.37.camel@lade.trondhjem.org> (Trond Myklebust's
	message of "Tue, 16 Jan 2007 07:33:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> On Sat, 2007-01-13 at 23:57 +0100, syrius.ml@no-log.org wrote:
>> Hi there,
>> 
>> I've been curious enough to try 2.6.20-rc5 with nfs4/kerberos.
>> It was working fine before. I was using 2.6.18.1 on the client and
>> 2.6.20-rc3-git4 on server and today i tried 2.6.20-rc5 on both client
>> and server. (both running up to date debian/sid)
>> Trying to mount a nfs4 or nfs3 share with krb5 (did try with krb5 and
>> krb5p) produces this oops on the client side:
>> (each time I tried i got the same oops)
>> 
>> ------------[ cut here ]------------
>> kernel BUG at net/sunrpc/sched.c:902!
>> [ SNIP ]
>> EIP: [<c03fcb1f>] rpc_release_task+0x8f/0xc0 SS:ESP 0068:f6f21be4
>
> Does the attached patch fix it for you?

Yes It does !
Thanks a lot.

-- 
