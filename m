Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTEAUwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTEAUwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:52:22 -0400
Received: from [210.22.78.238] ([210.22.78.238]:6400 "HELO trust-mart.com")
	by vger.kernel.org with SMTP id S262645AbTEAUwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:52:21 -0400
Date: Fri, 2 May 2003 05:04:51 +0800
From: hv-it <hv@trust-mart.com.cn>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at net/socket.c:147
Message-Id: <20030502050451.5b742a0a.hv@trust-mart.com.cn>
In-Reply-To: <1051821952.1407.6.camel@laptop.fenrus.com>
References: <1051821220.4440.1.camel@mharnois.mdharnois.net>
	<1051821952.1407.6.camel@laptop.fenrus.com>
Organization: gmo
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is happened with 2.5.68-bkx(x>=5),I think it's a protocol's bug with net_family_get and net_family_put in bkx's patch.
I use 2.5.68-bk11 which I have deleted net_family-get and net_family_put.All is fine to me.
My vmware's version is 4.

On 01 May 2003 22:45:53 +0200
Arjan van de Ven <arjanv@redhat.com> wrote:

> On Thu, 2003-05-01 at 22:33, Michael D. Harnois wrote:
> > This is with 2.5.68-bk11 but happened also with bk10.
> > 
> > May  1 15:30:20 mharnois kernel: ------------[ cut here ]------------
> > May  1 15:30:20 mharnois kernel: kernel BUG at net/socket.c:147!
> > May  1 15:30:20 mharnois kernel: invalid operand: 0000 [#1]
> > May  1 15:30:20 mharnois kernel: CPU:    0
> > May  1 15:30:20 mharnois kernel: EIP:   
> > 0060:[net_family_get+110/128]    Tainted: PF 
> 
> May  1 15:30:20 mharnois kernel:  <6>note: vmnet-bridge[9886] exited
> with preempt_count 2
> 
> 
> does it happen without vmware too ?
> 
