Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274631AbSITCap>; Thu, 19 Sep 2002 22:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274675AbSITCap>; Thu, 19 Sep 2002 22:30:45 -0400
Received: from ns.suse.de ([213.95.15.193]:61700 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S274631AbSITCap>;
	Thu, 19 Sep 2002 22:30:45 -0400
Date: Fri, 20 Sep 2002 04:35:49 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, akpm@digeo.com, taka@valinux.co.jp, alan@lxorguk.ukuu.org.uk,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
Message-ID: <20020920043549.A3047@wotan.suse.de>
References: <20020920040619.A30304@wotan.suse.de> <20020919.190154.57630807.davem@redhat.com> <20020920042819.A1289@wotan.suse.de> <20020919.192048.80494959.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020919.192048.80494959.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 07:20:48PM -0700, David S. Miller wrote:
>    From: Andi Kleen <ak@suse.de>
>    Date: Fri, 20 Sep 2002 04:28:19 +0200
>    
>    You cannot really use these instructions on Athlon,
> 
> I know that Athlon lacks these instructions, they are p4 sse2
> only.

AFAIK it is an SSE1 feature.

Athlon actually has movnti in newer models, just you do not really want to 
use it.

-Andi
