Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVCMSv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVCMSv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 13:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVCMSv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 13:51:26 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:18064 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261422AbVCMSvX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 13:51:23 -0500
Date: Sun, 13 Mar 2005 19:52:23 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Alan Cox <alan@redhat.com>, Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] x86: fix ESP corruption CPU bug
In-Reply-To: <42348474.7040808@aknet.ru>
Message-ID: <Pine.LNX.4.62.0503131950190.23588@alpha.polcom.net>
References: <42348474.7040808@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2005, Stas Sergeev wrote:

> Hi Alan.
>
> Attached patch works around the corruption
> of the high word of the ESP register, which
> is the official bug of x86 CPUs. The bug
> triggers only when the one is using the
> 16bit stack segment, and is described here:
> http://www.intel.com/design/intarch/specupdt/27287402.PDF

Does the bug also egsist on AMD CPU's? Does the patch add anything to 
kernels compiled for AMD CPU's?


Thanks,

Grzegorz Kulewski
