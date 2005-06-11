Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVFKUKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVFKUKW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVFKUKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:10:22 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:34184 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S261803AbVFKUJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:09:24 -0400
Message-ID: <000a01c56ec1$75f437d0$6401a8c0@adic.com>
From: "Steve Lord" <lord@xfs.org>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <pozsy@uhulinux.hu>, <linux-kernel@vger.kernel.org>,
       <rusty@rustcorp.com.au>
References: <42A99D9D.7080900@xfs.org><20050610112515.691dcb6e.akpm@osdl.org><20050611082642.GB17639@ojjektum.uhulinux.hu><42AAE5C8.9060609@xfs.org><20050611150525.GI17639@ojjektum.uhulinux.hu><42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org>
Subject: Re: Race condition in module load causing undefined symbols
Date: Sat, 11 Jun 2005 15:09:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the bizarre part is that I think this has been around for a while, but 
it
does not exhibit itself in redhat kernels which postdate the earliest
recolloction of me seeing it. 2.6.11-rc1 is the earliest I remember,
but I am not religious about updating the kernel on this box so
my samples are spotty.

The difference between the two may be that I recompile for a P4
while redhat uses a lowest common denominator cpu type.

If I get a chance this weekend I will try some other kernels and
report back. Maybe just start out by dumbing down my cpu
type.

Steve

> Stephen Lord <lord@xfs.org> wrote:
>>
>>  I disabled hyperthreading and things started working, so are there any
>>  HT related scheduling bugs right now?
>
> There haven't been any scheduler changes for some time.  There have been a
> few low-level SMT changes I think.
>
> Are you able to identify which kernel version broke it?
>
> 

