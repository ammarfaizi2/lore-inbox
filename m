Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTADStg>; Sat, 4 Jan 2003 13:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbTADStg>; Sat, 4 Jan 2003 13:49:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53822 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261295AbTADStg>; Sat, 4 Jan 2003 13:49:36 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: suparna@in.ibm.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: 2.5.54: Re: [PATCH][CFT] kexec (rewrite) for 2.5.52
References: <m1smwql3av.fsf@frodo.biederman.org>
	<20021231200519.A2110@in.ibm.com> <1041640372.12182.51.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2003 11:56:51 -0700
In-Reply-To: <1041640372.12182.51.camel@andyp>
Message-ID: <m1vg14kaks.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> Eric,
> 
> The patch applied cleanly to 2.5.54 for me.
> 
> The kexec portion works just fine and the reboot discovers all of the
> memory on my system using kexec_tools 1.8.
> 
> However, something has recently changed in the 2.5.5x series that causes
> the reboot to hang while calibrating the delay loop after a kexec
> reboot:

Thanks I will take a look.  It looks like something is definitely having
interrupt problems...

BTW, Have you tried booting an older kernel?
That would help indicate where the problem is.  I am pretty certain
it is from somewhere in the kernels initialization path.

Eric
