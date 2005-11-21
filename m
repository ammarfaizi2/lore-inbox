Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVKUWbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVKUWbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVKUWbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:31:46 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:41867 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751181AbVKUWbp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:31:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W5/Ul0y38LE2Duql0YfAA3a7+APCw+cUprmko0s7nR7W8R0GuMvCr3k0jLutyN9f60FHi8vKQgUWwh+OCnb7aQsc+O51w+JjYQXnYBH24bWsJF3d/jgNOvs1b9803HuXEmSO7G+RZw54WAnirnm44HG1htV6Xzc/qdTM9EAcdJs=
Message-ID: <86802c440511211431p57628e01o5c8030c4e09deaba@mail.gmail.com>
Date: Mon, 21 Nov 2005 14:31:44 -0800
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: x86_64: apic id lift patch
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, linuxbios@openbios.org
In-Reply-To: <20051121222429.GE20775@brahms.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com>
	 <20051121220605.GD20775@brahms.suse.de>
	 <86802c440511211417h737474fbt57946f4f2396b701@mail.gmail.com>
	 <20051121222429.GE20775@brahms.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> max_cores should be 2 here.
No, For E0 single core, x86_max_cores will be 1, the initial apicid
can not be shifted to node id....
>
>
> Is there a good reason in the BIOS to not make it contiguous?
>
amd8111, if i lift the bsp apic id, the jiffies will not be moving....,

YH
