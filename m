Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267864AbUI1OYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbUI1OYy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 10:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUI1OYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 10:24:54 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:54123 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267864AbUI1OXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 10:23:18 -0400
Message-ID: <5d6b657504092807233fe32310@mail.gmail.com>
Date: Tue, 28 Sep 2004 16:23:18 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Dave Jones <davej@redhat.com>, Brian McGrew <brian@doubledimension.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Probing for System Model Information
In-Reply-To: <20040928134705.GA11916@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E6456D527ABC5B4DBD1119A9FB461E35019377@constellation.doubledimension.com>
	 <20040928134705.GA11916@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works for my Inspiron 5150. Thanks, didn't know that.


Cheers,
Buddy


On Tue, 28 Sep 2004 14:47:05 +0100, Dave Jones <davej@redhat.com> wrote:
> On Tue, Sep 28, 2004 at 06:32:31AM -0700, Brian McGrew wrote:
>  > Good morning All!
>  >
>  > We exclusively ship Dell boxes with our hardware.  However, we use several different models, 1400's, 1600's, 2350's, 4600's and so on.  I need to write a small program to probe the system for the model information since I don't seem to find it in the logs anywhere.
>  >
>  > I know the model info is in there somewhere and it's accessible because if I look on the default factory installed version of Windows, it's listed.
>  >
>  > Does anyone know how to do this or can you point me to one that's already done or some samples?
>  
> You can find this info in the DMI tables assuming Dell filled
> them in with sensible data (which they usually do).
> 
> dmidecode will read these tables from userspace.
> 
>                 Dave
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
