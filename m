Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVLDOYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVLDOYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 09:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVLDOYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 09:24:11 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:29241 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932232AbVLDOYK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 09:24:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NwNAsh9JWiSHHkHusyeu4wgTNmZkFHj/HvOxTVrqdufTiS8HUeWnRjoKInbF3WEFECAG8rsV/EeM5pp4Ub8sXACr5T0vFp7eveJfEz/1/L9EmQawVJ/CJUBNeAeSnVvk3HKKby96xUfsSC/yM0X//tdWxEIjesNEAxi1KoZ8Iyo=
Message-ID: <c775eb9b0512040624ob4bcb3drfbdcdd427df2d2e3@mail.gmail.com>
Date: Sun, 4 Dec 2005 09:24:08 -0500
From: Bharath Ramesh <krosswindz@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: Only one processor detected in 8-Way opteron in 32-bit mode
Cc: Keith Mannthey <kmannth@gmail.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <p73psod4yat.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com>
	 <a762e240512011527s69053b8eg13ec4674c3e36b07@mail.gmail.com>
	 <c775eb9b0512011651kb0e1cb4xf79ca20372f6d76e@mail.gmail.com>
	 <c775eb9b0512011712x2f4f2f44t4cd11d5d6f60a9d8@mail.gmail.com>
	 <a762e240512011742p681df3bdic16598a85926dd67@mail.gmail.com>
	 <c775eb9b0512020732v3f41f91fpb3b4b61b0b539d92@mail.gmail.com>
	 <a762e240512021407p5a31c0daid902352625701ca2@mail.gmail.com>
	 <p73psod4yat.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you point me to the thread in which you posted the patch so that I
can try it out. I am limited to a 32-bit kernel as the library I want
use requires a 32bit kernel. I need to try to get some performance
results.

Thanks,
Bharath

On 03 Dec 2005 15:21:14 -0700, Andi Kleen <ak@suse.de> wrote:
> Keith Mannthey <kmannth@gmail.com> writes:
>
> > Welcome to hardware bring up.  Ok I looked a little closer at the
> > story.  In x86_64 the only check for valid apic is apicid < MAX_APICS
> > which make sense to me.
>
> It will still not work. He will need a variant of the physflat-i386
> patch I posted some time ago. However it needs some cleanup
> to be actually mergeable
>
> My recommendation is a 64bit kernel.
>
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
