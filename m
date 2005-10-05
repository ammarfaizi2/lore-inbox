Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbVJEMQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbVJEMQv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVJEMQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:16:50 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:13322 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965143AbVJEMQu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:16:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=r5Hczp3I2k3Hh1IDl9l3D4DTWI179obsrjKxVc2MXdFuMSelozuco1hJ9jloazHY4IVHziWZcRi5Y8vmleY7seNafpXPsXN1hV16VWO/WdY5jAa11D3A1MFr8J6cTu6sNrU5tvGq6fMRX0Tae35D2OmkBzPiy6kfQJXjpWUJ/zQ=
Message-ID: <309a667c0510050516i113dd125t50fb1f41442027a7@mail.gmail.com>
Date: Wed, 5 Oct 2005 17:46:49 +0530
From: devesh sharma <devesh28@gmail.com>
Reply-To: devesh sharma <devesh28@gmail.com>
To: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
Subject: Re: [NUMA , x86_64] numa=fake=2 boot time option
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Eric,
Even I have tested this with amd opteron on 2.6.9 successfully.
Ok Now I will try it with newer version.

On 10/5/05, Eric Dumazet <dada1@cosmosbay.com> wrote:
> Hi devesh,
>
> I'm sorry I did not notice your mail, I only see it now.
>
> devesh sharma a écrit :
> > Hello Eric,
> >
> > I am trying to boot 2.6.9 kernel with numa=fake=2 boot time option but
> > my kernel get penic saying
> >
> > kernel penic : not syncing : kmem_cache_create() failed!
> >
> > My machine is 64bit dual intel xeon with 4 GB physical memory!
> >
> > Is numa=fake option only available with Opteron machines or there is
> > some physical memory limit after which this option works?
>
>
> Please check with linux-2.6.13 and/or latest linux-2.6.14-rc3
>
> I tested it with success on a amd64 with 1GB of ram, and "numa=fake=2"
>
> But it's true I had panic with "numa=fake=2" in the past (2.6.12 maybe I dont
> remember very well), so maybe this option is not well tested/or was fixed lately.
>
>
> See you
> Eric
>
