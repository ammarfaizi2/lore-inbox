Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275082AbRJJIU4>; Wed, 10 Oct 2001 04:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275086AbRJJIUq>; Wed, 10 Oct 2001 04:20:46 -0400
Received: from t2.redhat.com ([199.183.24.243]:3318 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S275082AbRJJIUd>; Wed, 10 Oct 2001 04:20:33 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <32879.24.255.76.12.1002701163.squirrel@webmail.morcant.org> 
In-Reply-To: <32879.24.255.76.12.1002701163.squirrel@webmail.morcant.org> 
To: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Oct 2001 09:20:58 +0100
Message-ID: <3869.1002702058@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



sirmorcant@morcant.org said:
>     After compiling 2.4.11 I noticed modprobe picking up some of the
> tainted modules that were marked in the update.

>     What surprised me was the PPP compression modules, I didn't use
> PPP in 2.4.10 so maybe the notice was there in 2.4.10, but I didn't
> use them so I didn't see it. I shouldn't have been surprised, but I
> was. BSD compression, BSD license... doh... :> 

BSD-licensed modules shouldn't mark the kernel as tainted. If they do, 
that's surely a bug.

Any code which is distributed as part of the kernel source tree has a 
sane, if not 100% compatible, licence and shouldn't taint your kernel.

--
dwmw2


