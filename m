Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbSJUVzE>; Mon, 21 Oct 2002 17:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261717AbSJUVzE>; Mon, 21 Oct 2002 17:55:04 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:1263 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261715AbSJUVzD>; Mon, 21 Oct 2002 17:55:03 -0400
Date: Mon, 21 Oct 2002 18:01:10 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: atai@atai.org, lichengtai@yahoo.com, linux-kernel@vger.kernel.org,
       greearb@candelatech.com
Subject: Re: Tigon3 driver problem with raw socket on 2.4.20-pre10-ac2
Message-ID: <20021021180110.I27389@redhat.com>
References: <20021017.231249.14334285.davem@redhat.com> <20021019060221.92006.qmail@web10504.mail.yahoo.com> <20021018.225848.25861067.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021018.225848.25861067.davem@redhat.com>; from davem@redhat.com on Fri, Oct 18, 2002 at 10:58:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 10:58:48PM -0700, David S. Miller wrote:
>    From: Andy Tai <lichengtai@yahoo.com>
>    Date: Fri, 18 Oct 2002 23:02:21 -0700 (PDT)
> 
>    Thanks for your sugestion.  With Linux 2.4.19, the
>    problem goes away.  So something is wrong with the
>    2.4.20-pre kernels as related to the AMD Athlon...
>    
> To be honest, I have had a few relaibly reocurring lockups of my
> Athlon at night.

I had this problem with -ac for a while, but one of Alan's newer 
kernels finally fixed it.  I suspect the problem was related to 
nfs, but I've not yet tracked down exactly which patch fixed.  
That machine is a A7M266D with two MP 2000+s and an older AGP card 
which doesn't draw much power.

		-ben
