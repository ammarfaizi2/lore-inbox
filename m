Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263395AbTCNRVU>; Fri, 14 Mar 2003 12:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263397AbTCNRVU>; Fri, 14 Mar 2003 12:21:20 -0500
Received: from sdfw-ext.castandcrew.com ([63.113.17.130]:20979 "EHLO
	sddev.castandcrew.com") by vger.kernel.org with ESMTP
	id <S263395AbTCNRVT>; Fri, 14 Mar 2003 12:21:19 -0500
From: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20 instability on bigmem systems?
Date: Fri, 14 Mar 2003 09:31:15 -0800
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200303131627.22572.gregory@castandcrew.com> <200303131955.27060.gregory@castandcrew.com> <20030314041307.GK20188@holomorphy.com>
In-Reply-To: <20030314041307.GK20188@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303140931.15541.gregory@castandcrew.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 March 2003 20:13, William Lee Irwin III wrote:
> Hmm, neither slabinfo nor meminfo show the machine being under any
> stress. Were they generated while the problem was happening?
>
> The useful information would be to collect meminfo and slabinfo while
> kswapd and updated are spinning. Also, cpuinfo doesn't ever change,
> (at least while being run on the same box) so you can leave that out.

Ahh.  I was a bit out of it yesterday, and didn't think to actually stress 
the machine. :\

I'll be able to give it a good beating this weekend sometime.

> BTW, oopses tracing back into the VM doesn't help. It's usually someone
> doing something wrong the VM checks for. In this case I'll bet someone
> (i.e. LVM) called vmalloc() with interrupts off.

Hmm... Okay, mind if I quote you when I post that oops the the lvm list? :)

Thanks again,
Gregory

-- 
Gregory K. Ruiz-Ade <gregory@castandcrew.com>
Sr. Systems Administrator
Cast & Crew Entertainment Services, Inc.

