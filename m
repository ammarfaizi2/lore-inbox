Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbUEHQUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUEHQUW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 12:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUEHQUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 12:20:22 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:63406 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263188AbUEHQUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 12:20:19 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-rc3-mm2
Date: Sat, 8 May 2004 18:25:52 +0200
User-Agent: KMail/1.5
Cc: rusty@rustcorp.com.au, ak@muc.de, linux-kernel@vger.kernel.org
References: <20040505013135.7689e38d.akpm@osdl.org> <200405081329.43017.rjwysocki@sisk.pl> <20040508043149.63fd9498.akpm@osdl.org>
In-Reply-To: <20040508043149.63fd9498.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405081733.49473.rjwysocki@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 of May 2004 13:31, Andrew Morton wrote:
> "R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
> > Sute, it's like that:
> >
> >  kernel /boot/vmlinuz-2.6.6-rc3-mm2 root=/dev/sdb3 vga=792 hdc=ide-scsi
> >  console=ttyS0,115200 console=tty0
>
> Please try `console=ttyS0'.

I have.  It does not help. :-(

Still, reversing the Move-saved_command_line-to-init-mainc.patch _does_ help, 
even with the above command line.  I guess it's an x86_64-specific issue.

