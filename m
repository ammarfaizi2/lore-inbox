Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbUBEME4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 07:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbUBEME4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 07:04:56 -0500
Received: from med-gwia-02a.med.umich.edu ([141.214.93.150]:51995 "EHLO
	med-gwia-02a.med.umich.edu") by vger.kernel.org with ESMTP
	id S264476AbUBEMEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 07:04:52 -0500
Message-Id: <s021eb13.042@med-gwia-02a.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Thu, 05 Feb 2004 07:04:26 -0500
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: change kernel name
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note the words 'after the compilation'.

Nik


>>> "Richard B. Johnson" <root@chaos.analogic.com> 02/04/04 07:38AM
>>>
On Tue, 3 Feb 2004, Gaspar Bakos wrote:

> Hello,
>
> I have the following question:
> If I compile the kernel (2.4.*) and boot it in, then the
kernel-release,
> as shown by 'uname -r' will be the string that was in the
EXTRAVERSION
> string from the kernel Makefile.
> Is there any way to change this 'identity' of the kernel after the
> compilation?
> Such as
> changekernelname bzImage "newname"

Put anything you want in the structure, system_utsname, in your copy
of
linux-nn-nn/init/version.c.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/
