Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317852AbSHUEqZ>; Wed, 21 Aug 2002 00:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSHUEqZ>; Wed, 21 Aug 2002 00:46:25 -0400
Received: from zok.SGI.COM ([204.94.215.101]:62860 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317852AbSHUEqY>;
	Wed, 21 Aug 2002 00:46:24 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: moret@cs.unm.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with modules (modutils) and 2.5.31 kernel 
In-reply-to: Your message of "Tue, 20 Aug 2002 20:25:19 CST."
             <20020821022519.GA2554@cs.unm.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Aug 2002 14:50:17 +1000
Message-ID: <7675.1029905417@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2002 20:25:19 -0600, 
moret@cs.unm.edu wrote:
>I searched for, but could not find references to, a problem
>I have with 2.5.31 and modutils.
>  insmod, depmod, update-modules all fail with the message:
>
>=>   kernel: QM_SYMBOLS: Bad address

Disable CONFIG_PREEMPT and rebuild the kernel.

