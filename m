Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282715AbRK0Bc5>; Mon, 26 Nov 2001 20:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282716AbRK0Bcr>; Mon, 26 Nov 2001 20:32:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63756 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282715AbRK0Bck>; Mon, 26 Nov 2001 20:32:40 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Release Policy
Date: 26 Nov 2001 17:32:18 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tuqf2$eri$1@cesium.transmeta.com>
In-Reply-To: <4.3.2.7.2.20011126113409.00bfaa70@mail.osagesoftware.com> <Pine.LNX.4.21.0111261328450.13681-100000@freak.distro.conectiva> <3C02E682.4CDC6858@zip.com.au> <20011126.171301.50592818.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011126.171301.50592818.davem@redhat.com>
By author:    "David S. Miller" <davem@redhat.com>
In newsgroup: linux.dev.kernel
>
>    From: Andrew Morton <akpm@zip.com.au>
>    Date: Mon, 26 Nov 2001 17:04:02 -0800
>    
>    Marcelo, if someone sends you a patch which has not been thoroughly
>    reviewed on the appropriate mailing list, I would urge you to
>    peremptorily shitcan it.  There is no reason why you alone should
>    be responsible for reviewing kernel changes.
> 
> Are you suggesting that, for example, I should send every Sparc change
> to this list?
> 

appropriate != this.

> I bet a lot of what he is seeing are driver and arch updates.
> 
> Such updates really only need to go through his "stupid filter"
> when it is coming from the maintainer, but it does add up and
> take up time.

Obviously.  If it's for a maintained subsystem:

a) if it's from the subsystem maintainer, sanity-check it.
b) if it's not, dump it or reject with the appropriate notice.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
