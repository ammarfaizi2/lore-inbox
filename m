Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbRCIXVZ>; Fri, 9 Mar 2001 18:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130754AbRCIXVP>; Fri, 9 Mar 2001 18:21:15 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:58633 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130753AbRCIXVH>;
	Fri, 9 Mar 2001 18:21:07 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Oleg Drokin <green@dredd.crimea.edu>
cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        usb@in.tum.de, jerdfelt@valinux.com
Subject: Re: khubd oops in 2.4.2-ac16 
In-Reply-To: Your message of "Fri, 09 Mar 2001 21:51:57 +0300."
             <20010309215157.A1868@dredd.crimea.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 10 Mar 2001 10:20:18 +1100
Message-ID: <2449.984180018@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001 21:51:57 +0300, 
Oleg Drokin <green@dredd.crimea.edu> wrote:
>ksymoops 2.3.5 on i686 2.4.2-ac16.  Options used
>Warning (compare_maps): mismatch on symbol __module_author  , usbnet says c89338c0, /lib/modules/2.4.2-ac16/kernel/drivers/usb/usbnet.o says c893472c.  Ignoring /lib/modules/2.4.2-ac16/kernel/drivers/usb/usbnet.o entry

You are using a very old modutils, somewhere before 2.3.19.  You need
at least modutils 2.4.2 for this kernel, modutils 2.4.3 would be
better.

