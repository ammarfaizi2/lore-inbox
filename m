Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269898AbRHEBtb>; Sat, 4 Aug 2001 21:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269896AbRHEBtU>; Sat, 4 Aug 2001 21:49:20 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:27920 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269898AbRHEBtI>;
	Sat, 4 Aug 2001 21:49:08 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: rich+ml@lclogic.com
cc: linux-kernel@vger.kernel.org
Subject: Re: module unresolved symbols 
In-Reply-To: Your message of "Sat, 04 Aug 2001 17:39:17 MST."
             <Pine.LNX.4.30.0108041726050.8186-100000@baddog.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 Aug 2001 11:48:45 +1000
Message-ID: <2261.996976125@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Aug 2001 17:39:17 -0700 (PDT), 
<rich+ml@lclogic.com> wrote:
>Starting with a stock RH 7.0 install, I changed a single kernel config
>item and recompiled with 'make defs clean bzImage modules
>modules_install'.
>
>Booted on the new kernel and depmod complains that dozens of modules
>contain unresolved symbols. Back to the original kernel, now it also
>complains of unresolved symbols (not the same set of modules, and modules
>that were previously OK).

Broken kernel makefiles when module symbols are turned on.
http://www.tux.org/lkml/#s8-8

