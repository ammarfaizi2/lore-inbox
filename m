Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273054AbRIWBtc>; Sat, 22 Sep 2001 21:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273098AbRIWBtW>; Sat, 22 Sep 2001 21:49:22 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:55813 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S273054AbRIWBtP>;
	Sat, 22 Sep 2001 21:49:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
Subject: Re: Tainting kernels for non-GPL or forced modules 
In-Reply-To: Your message of "Sat, 22 Sep 2001 16:28:48 -0400."
             <200109222028.f8MKSmY97869@saturn.cs.uml.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Sep 2001 11:48:26 +1000
Message-ID: <5508.1001209706@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2001 16:28:48 -0400 (EDT), 
"Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:
>Keith Owens writes:
>> I have started work on the patch for /proc/sys/kernel/tainted with the
>> corresponding modutils and ksymoops changes.  insmod of a non-GPL
>> module ORs /proc/sys/kernel/tainted with 1, insmod -f ORs with 2.
>
>So now these will taint the kernel?
>
>LGPL
>2-clause BSD
>X11
>public domain

No, the list of GPL licenses is taken from include/linux/module.h, q.v.

