Return-Path: <linux-kernel-owner+w=401wt.eu-S1160997AbXAEHfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbXAEHfz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160998AbXAEHfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:35:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:48477 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160997AbXAEHfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:35:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o3leXwOgozg1QkoijhaD6j/zMcCg/jWZztsT2AD/hVc6XGV3Uruqii0EbkdUlm9Qm6NX0iIFi+T0+8aurTBJ9XOlvnidg5qXNXwVM7BxOtLEro0hFwRKkIlJMPnMXRFTh2WzImP3/LAkwlE53v9fxKN9rpyC4ELZ/UoMvsxorgQ=
Message-ID: <4df04b840701042335t5f99b21cl4962dec35c0ffa1a@mail.gmail.com>
Date: Fri, 5 Jan 2007 15:35:53 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: "Zhou Yingchao" <yingchao.zhou@gmail.com>
Subject: Re: [PATCH 2.6.16.29 1/1] memory: enhance Linux swap subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <67029b170612292150q7f59390cp83f35698ac7f7bd7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840612260018u4be268cod9886edefd25c3a@mail.gmail.com>
	 <67029b170612260103o9193346hde726a3f09afa57f@mail.gmail.com>
	 <4df04b840612261933g6eab036rb474930828dadb6d@mail.gmail.com>
	 <67029b170612292150q7f59390cp83f35698ac7f7bd7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, a new idea to re-write swap subsystem at all. In fact, it's an
impossible task to me, so I provide a compromising solution -- pps
(pure private page system).

2006/12/30, Zhou Yingchao <yingchao.zhou@gmail.com>:
> 2006/12/27, yunfeng zhang <zyf.zeroos@gmail.com>:
> > To multiple address space, multiple memory inode architecture, we can introduce
> > a new core object -- section which has several features
> Do you mean "in-memory inode"  or "memory node(pglist_data)" by "memory inode" ?
> > The idea issued by me is whether swap subsystem should be deployed on layer 2 or
> > layer 3 which is described in Documentation/vm_pps.txt of my patch. To multiple
> > memory inode architecture, the special memory model should be encapsulated on
> > layer 3 (architecture-dependent), I think.
> I guess that you are  wanting to do something to remove arch-dependent
> code in swap subsystem.  Just like the pud introduced in the
> page-table related codes. Is it right?
> However, you should verify that your changes will not deteriorate
> system performance. Also, you need to maintain it for a long time with
> the evolution of mainline kernel before it is accepted.
>
> Best regards
> --
> Yingchao Zhou
> ***********************************************
>  Institute Of Computing Technology
>  Chinese Academy of Sciences
> ***********************************************
>
