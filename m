Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264251AbTCXPj5>; Mon, 24 Mar 2003 10:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264252AbTCXPj4>; Mon, 24 Mar 2003 10:39:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4266
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264251AbTCXPj4>; Mon, 24 Mar 2003 10:39:56 -0500
Subject: Re: [Fwd: RE: kernel compile on phoebe 3]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1048514986.645.30.camel@teapot>
References: <1048514986.645.30.camel@teapot>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048525435.25655.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Mar 2003 17:03:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 14:09, Felipe Alfaro Solana wrote:
> -----Forwarded Message-----
> 
> From: Pavel Rozenboim <pavelr@coresma.com>
> To: phoebe-list@redhat.com
> Subject: RE: kernel compile on phoebe 3
> Date: 24 Mar 2003 15:22:44 +0200
> 
> For some reason I don't get /proc/ksyms file with 2.5 kernels I compile, and
> that causes rc.sysinit to set /proc/sys/kernel/modprobe to /bin/true. What
> option enables /proc/ksyms creation?

You need to modify rc.sysinit. ksyms is gone - test /proc/modules which
is probably what the script should always have done

