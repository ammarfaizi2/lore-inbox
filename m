Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTKFDem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 22:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbTKFDem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 22:34:42 -0500
Received: from mid-1.inet.it ([213.92.5.18]:36021 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S263330AbTKFDel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 22:34:41 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: test9 and bluetooth
Date: Thu, 6 Nov 2003 04:34:36 +0100
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200311021853.47300.cova@ferrara.linux.it> <1068031899.10388.180.camel@pegasus>
In-Reply-To: <1068031899.10388.180.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200311060434.36613.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 12:31, mercoledì 05 novembre 2003, Marcel Holtmann ha scritto:

> > I get no informations/messages in logs.
> > I'm using the same dogle and usb devices on a 2.4.21 kernel (on a
> > different HW) and I can remove the dongle without any problem.
> >
> > If more informations or tries are needed just let me know.
>
> please try this with a non SMP kernel and/or a non preempt kernel. Do
> you have enabled the Bluetooth SCO support for the HCI USB driver?

I've tried with UP kernel (test9 straight, no bk-wathever), preempt, and it 
freezes in the very same way. Tomorrow I'll try with UP and SMP no preempt.
the SCO module was compiled but not loaded.
I've noticed several Oopses during system shutdown, but I can't say if this is 
related to the bluetooth issue. Tomorrow I'll try again and I'll post also 
the oopses. 

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

