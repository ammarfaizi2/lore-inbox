Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319186AbSHND5u>; Tue, 13 Aug 2002 23:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319190AbSHND5t>; Tue, 13 Aug 2002 23:57:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15886 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319186AbSHND5s>;
	Tue, 13 Aug 2002 23:57:48 -0400
Message-ID: <3D59D88B.16C23205@zip.com.au>
Date: Tue, 13 Aug 2002 21:11:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>, "H. Peter Anvin" <hpa@zytor.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
References: <3D59CBFA.9CFC9FEE@zip.com.au> <20020813235803.A15947@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> On Tue, Aug 13, 2002 at 08:18:18PM -0700, Andrew Morton wrote:
> >
> > The patch allows userspace to issue printk's, via sys_syslog():
> 
> This is an incredibly bad idea.  It has security hole written all over it.
> Any user can now spam the kernel's log ringbuffer and overrun potentially
> important messages.
> 

It requires root.
