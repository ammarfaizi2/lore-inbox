Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132508AbRDWWmz>; Mon, 23 Apr 2001 18:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132502AbRDWWju>; Mon, 23 Apr 2001 18:39:50 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:47120 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132725AbRDWWjT>; Mon, 23 Apr 2001 18:39:19 -0400
Date: Mon, 23 Apr 2001 16:32:48 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: filp_open() in 2.2.19 causes memory corruption
Message-ID: <20010423163248.B1131@vger.timpanogas.org>
In-Reply-To: <001d01c0cc33$7e62daa0$5517fea9@local> <3942.988063428@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3942.988063428@redhat.com>; from dwmw2@infradead.org on Mon, Apr 23, 2001 at 11:03:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 11:03:48PM +0100, David Woodhouse wrote:
> 
> manfred@colorfullife.com said:
> > Are you sure the trace is decoded correctly?
> 
> > > CPU:    0 
> > > EIP:    0010:[sys_mremap+31/884]  
> 
> Probably not. It looks like it was munged by klogd. Some distributions are 
> still shipping with klogd configured to destroy the original information on 
> the way to the log, without even making it do a sanity check that the 
> System.map it's using actually matches the current kernel.
> 
> Jeff, please disable the broken klogd symbol munging and reproduce it,
> running the oops through ksymoops manually. Ksymoops should have built-in 
> sanity checks on the System.map it tries to use.
> 
> Also, please make sure you report this as a serious bug with the vendor of 
> whatever distribution you're running on this box.
> 


David,

I will comply and repost the oops.

Jeff

> --
> dwmw2
> 
