Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280096AbRKIUpl>; Fri, 9 Nov 2001 15:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280104AbRKIUpb>; Fri, 9 Nov 2001 15:45:31 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:37881
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280096AbRKIUpV>; Fri, 9 Nov 2001 15:45:21 -0500
Date: Fri, 9 Nov 2001 12:45:14 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "David S. Miller" <davem@redhat.com>
Cc: smpcomputing@free.fr, alan@lxorguk.ukuu.org.uk, ak@suse.de,
        anton@samba.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011109124514.A446@mikef-linux.matchmail.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	smpcomputing@free.fr, alan@lxorguk.ukuu.org.uk, ak@suse.de,
	anton@samba.org, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <E162BFV-0002y1-00@the-village.bc.nu> <20011109.045455.74749430.davem@redhat.com> <02e801c16920$9ca9acc0$0a01a8c0@beawrk10> <20011109.052650.104644078.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011109.052650.104644078.davem@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 05:26:50AM -0800, David S. Miller wrote:
>    From: "Philip Dodd" <smpcomputing@free.fr>
>    Date: Fri, 9 Nov 2001 14:15:32 +0100
> 
>    > I think a boot time commandline option is more appropriate
>    > for something like this.
>    
>    In the light of what was said about embedded systems, I'm not really sure a
>    boot time option really is the way to go...
> 
> All the hash tables in question are allocated dynamically,
> we size them at boot time, the memory is not consumed until
> the kernel begins executing.  So a boottime option would be
> just fine.

How much is this code going to affect the kernel image size?
