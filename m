Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSKESDd>; Tue, 5 Nov 2002 13:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265143AbSKESDc>; Tue, 5 Nov 2002 13:03:32 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:51441 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S265139AbSKESDa>; Tue, 5 Nov 2002 13:03:30 -0500
Date: Tue, 5 Nov 2002 13:10:05 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: kexec (was: Re: What's left over.)
Message-ID: <20021105131005.E3078@redhat.com>
References: <20021031020836.E576E2C09F@lists.samba.org> <20021105142943.I1407@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021105142943.I1407@almesberger.net>; from wa@almesberger.net on Tue, Nov 05, 2002 at 02:29:43PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 02:29:43PM -0300, Werner Almesberger wrote:
> I view kexec as an "enabler", much like initrd, which had to be
> part of the kernel for a while before people started to figure out
> how to use it. (At this year's OLS, somebody told me they just
> "discovered" initrd and are now using it. Oh well, it's only been
> around for six years ;-)

kexec is also a great enabled for a non-intrusive kernel dump 
facility done correctly by booting into a new kernel image (which 
avoids the whole difficulty on x86 with BIOSes wiping out RAM at 
reboot).

		-ben
