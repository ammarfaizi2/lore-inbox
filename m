Return-Path: <linux-kernel-owner+w=401wt.eu-S1751051AbWLLDRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWLLDRB (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 22:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWLLDRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 22:17:01 -0500
Received: from web32611.mail.mud.yahoo.com ([68.142.207.238]:32163 "HELO
	web32611.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751051AbWLLDRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 22:17:00 -0500
X-YMail-OSG: ktoo.toVM1me7166b5Znef7rODUEzitrges8.c91KGx2VnNax_RkUdn3fmssAHjZCWXSKla0C0ntUOPEzawC.n0Owfbtiu03rKCp.kHkgEIhFs8xHqJiJw--
X-RocketYMMF: knobi.rm
Date: Mon, 11 Dec 2006 19:16:59 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: [2.6.19] NFS: server error: fileid changed
To: Trond Myklebust <trond.myklebust@fys.uio.no>, knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1165883155.22849.8.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <932927.29357.qm@web32611.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Mon, 2006-12-11 at 15:44 -0800, Martin Knoblauch wrote:
> >  So far, we are only seeing it on amd-mounted filesystems, not on
> > static NFS mounts. Unfortunatelly, it is difficult to avoid "amd"
> in
> > our environment.
> 
> Any chance you could try substituting a recent version of autofs?
> This
> sort of problem is more likely to happen on partitions that are
> unmounted and then remounted often. I'd just like to figure out if
> this
> is something that we need to fix in the kernel, or if it is purely an
> amd problem.
> 
> Cheers
>   Trond
> 
Hi Trond,

 unfortunatelly I have no controll over the mounting maps, as they are
maintained from different people. So the answer is no. Unfortunatelly
the customer has decided on using am-utils. This has been hurting us
(and them) for years ...

 Your are likely correct when you hint towards partitions which are
frequently remounted.  

 In any case, your help is appreciated.

Cheers
Martin


------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
