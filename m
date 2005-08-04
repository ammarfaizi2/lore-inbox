Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVHDQij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVHDQij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVHDQfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:35:34 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:44435 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262598AbVHDQdl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:33:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BeEmhJFLf+HN1vMGDt/sfAOLEI49vu5gQ8aw57CApY+/3U9HpS3t2psVtbnb9s2RcdJilhdEOrfFZbQtNz/insVJCLHPIGlRgyPILuFFipnYMQEHjX4d+9266MwPALoWeUqpv2JB0Am3PpI5W6nd5Q6t+svuuHc5SF47wKfYxFY=
Message-ID: <86802c44050804093374aca360@mail.gmail.com>
Date: Thu, 4 Aug 2005 09:33:38 -0700
From: yhlu <yhlu.kernel@gmail.com>
Reply-To: yhlu <yhlu.kernel@gmail.com>
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: mthca and LinuxBIOS (was: [PATCH 1/2] [IB/cm]: Correct CM port redirect reject codes)
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <52u0i6b9an.fsf_-_@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20057281331.dR47KhjBsU48JfGE@cisco.com>
	 <20057281331.7vqhiAJ1Yc0um2je@cisco.com>
	 <86802c44050803175873fb0569@mail.gmail.com>
	 <52u0i6b9an.fsf_-_@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YES.

I will send you the output message later about "CONFIG_INFINIBAND_MTHCA_DEBUG=y"

YH

On 8/3/05, Roland Dreier <rolandd@cisco.com> wrote:
>     yhlu> In LinuxBIOS, If I enable the prefmem64 to use real 64
>     yhlu> range. the IB driver in Kernel can not be loaded.
> 
> What does it mean to "enable the prefmem64 to use real 64 range"?
> 
> Does the driver work if you don't do this?
> 
>     yhlu> ib_mthca 0000:04:00.0: Failed to initialize queue pair table, aborting.
> 
> Can you add printk()s to mthca_qp.c::mthca_init_qp_table() to find out
> how far the function gets before it fails?
> 
> It would also be useful for you to build with CONFIG_INFINIBAND_MTHCA_DEBUG=y
> and send the kernel output you get with that.
> 
>  - Roland
>
