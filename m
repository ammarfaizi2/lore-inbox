Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132653AbRDQOTq>; Tue, 17 Apr 2001 10:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132652AbRDQOTg>; Tue, 17 Apr 2001 10:19:36 -0400
Received: from ns.suse.de ([213.95.15.193]:52749 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132651AbRDQOT1>;
	Tue, 17 Apr 2001 10:19:27 -0400
Date: Tue, 17 Apr 2001 16:19:19 +0200
From: Andi Kleen <ak@suse.de>
To: Eric Weigle <ehw@lanl.gov>
Cc: Sampsa Ranta <sampsa@netsonic.fi>, linux-net@vger.kernel.org,
        linux-kernel@vger.kernel.org, zebra@zebra.org
Subject: Re: ARP responses broken!
Message-ID: <20010417161919.A8842@gruyere.muc.suse.de>
In-Reply-To: <3ADB637B.13E4F1AD@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ADB637B.13E4F1AD@lanl.gov>; from ehw@lanl.gov on Mon, Apr 16, 2001 at 03:26:19PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2001 at 03:26:19PM -0600, Eric Weigle wrote:
> Hello-
> 
> This is a known 'feature' of the Linux kernel, and can help with load sharing
> and fault tolerance. However, it can also cause problems (such as when one nic
> in a multi-nic machine fails and you don't know right away).
> 
> There are three 'solutions' I know of:
> 
>   * In recent 2.2 kernels, it was possible to fix this by doing the following as

Or use arpfilter in even newer 2.2 kernels; which filters based on the routing
table. "hidden" is quite a sledgehammer which often does more harm than good.


-Andi
