Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281245AbRLAAht>; Fri, 30 Nov 2001 19:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281248AbRLAAhk>; Fri, 30 Nov 2001 19:37:40 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:39923
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281245AbRLAAh1>; Fri, 30 Nov 2001 19:37:27 -0500
Date: Fri, 30 Nov 2001 16:37:21 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Joe Rice <jrice@bigidea.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still having problems with eepro100
Message-ID: <20011130163721.J504@mikef-linux.matchmail.com>
Mail-Followup-To: Joe Rice <jrice@bigidea.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011130180827.E2265@bigidea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011130180827.E2265@bigidea.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 06:08:27PM -0600, Joe Rice wrote:
> 
> Hello, 
>   I'm having the same type of problems that was talked
> about in this thread.  I have seen the same error
> on kernels 2.4.7 - 2.4.10, which is:
> 
> eth0: card reports no resources.
> __alloc_pages: 0_order allocation failed (gfp=0x20/0) from c012da00
>
> at which point i see NFS timeouts or the machine hangs
> and requires a cold reboot.
>
> also, I haven't had any luck with the Intel e100 driver.
>

e100 probably doesn't help because that is a VM issue triggered by nfs and
networking.

> 
> I'm now testing on 10 of the nodes the 2.4.16 kernel.  They
> have been under a moderate load and i haven't seen any
> problems yet.  I still plan on doing a large load test
> on this newer kernel.
> 

Let us know if there's any problems.  And if things are better that wouldn't
hurt reporting either ;)
