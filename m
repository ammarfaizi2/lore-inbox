Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276982AbRKMRFd>; Tue, 13 Nov 2001 12:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276956AbRKMRFX>; Tue, 13 Nov 2001 12:05:23 -0500
Received: from air-1.osdl.org ([65.201.151.5]:34570 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S277068AbRKMRFJ>;
	Tue, 13 Nov 2001 12:05:09 -0500
Message-ID: <3BF1527F.2042E0E1@osdl.org>
Date: Tue, 13 Nov 2001 09:03:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: Lee Howard <faxguy@deanox.com>, linux-kernel@vger.kernel.org
Subject: Re: lp oops with kernel 2.4.15-pre2
In-Reply-To: <3.0.6.32.20011112165757.00e404b0@server.deanox.com> <20011113113029.N25718@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Mon, Nov 12, 2001 at 04:57:57PM -0700, Lee Howard wrote:
> 
> > Nov 12 12:02:44 zelda kernel: EIP:    0010:[kmem_cache_alloc+100/176]
> [...]
> > Nov 12 12:02:44 zelda kernel: Call Trace: [d_alloc+23/368] [sprintf+18/32]
> > [sock_map_fd+153/352] [unix_create+92/112] [sock_create+214/256]
> > Nov 12 12:02:44 zelda kernel:    [dentry_open+346/384] [sys_socket+41/80]
> > [sys_socketcall+96/464] [do_page_fault+0/1200] [error_code+52/60]
> > [system_call+51/56]
> 
> This doesn't seem to be lp- or parport-related.  What else was the
> machine doing at the time?

Running the oops thru ksymoops would be helpful also.
See linux/REPORTING-BUGS file.

~Randy
