Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUJJR3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUJJR3r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 13:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268378AbUJJR3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 13:29:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:758 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S268372AbUJJR3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 13:29:44 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: John Richard Moser <nigelenki@comcast.net>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       linux-kernel@vger.kernel.org,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. " Com <amakarov@ru.mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>
In-Reply-To: <4169293B.3020502@comcast.net>
References: <41677E4D.1030403@mvista.com>  <4169293B.3020502@comcast.net>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1097429376.17309.5.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 10 Oct 2004 10:29:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-10 at 05:21, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Sven-Thorsten Dietrich wrote:
> |
> | Announcing the availability of prototype real-time (RT)
> | enhancements to the Linux 2.6 kernel.
> |
> | We will submit 3 additional emails following this one, containing
> | the remaining 3 patches (of 4) inline, with their descriptions.
> |
> | Download:
> |
> | Patches against the Linux-2.6.9-rc3 kernel are available at:
> |
> | ftp://source.mvista.com/pub/realtime/Linux-2.6.9-rc3-RT_irqthreads.patch
> | ftp://source.mvista.com/pub/realtime/Linux-2.6.9-rc3-RT_mutex.patch
> | ftp://source.mvista.com/pub/realtime/Linux-2.6.9-rc3-RT_spinlock1.patch
> | ftp://source.mvista.com/pub/realtime/Linux-2.6.9-rc3-RT_spinlock2.patch
> |
> | The patches are to be applied to the linux-2.6.9-rc3 kernel in the
> | order listed above.
> 
> Does any of this 'work' on x86_64 yet?  I heard that Ingo's voluntary
> pre-empt was x86 only and didn't work on amd64; this stuff's kinda new,
> does it work outside x86 yet?
> 
> I'd like to see what these kinds of things do.  :)


	No it's x86 only right now. The mutex is partly in assembly, and the
IRQ threads that we are using are (both of them) x86 only. 

Daniel Walker

