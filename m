Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbSKKDzT>; Sun, 10 Nov 2002 22:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbSKKDzT>; Sun, 10 Nov 2002 22:55:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62793 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265414AbSKKDzR>; Sun, 10 Nov 2002 22:55:17 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       fastboot@osdl.org
Subject: Re: kexec for 2.5.46
References: <m14ravfbjj.fsf@frodo.biederman.org>
	<1036631471.10457.233.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Nov 2002 20:59:22 -0700
In-Reply-To: <1036631471.10457.233.camel@andyp>
Message-ID: <m1adkgbvtx.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Tue, 2002-11-05 at 22:38, Eric W. Biederman wrote:
> > Linus please apply,
> 
> 
> FYI: patch applied cleanly for me.
> 
> After fudging kexec-tools-1.4 to correct for the new syscall number:

O.k.  After looking more this sounds like all of the systems of being uniprocessor
but still having apic support enabled.  And since I don't have the apic shutdown
code in there it doesn't work.

Eric
