Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263644AbUDUTYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263644AbUDUTYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 15:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUDUTYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 15:24:38 -0400
Received: from hera.kernel.org ([63.209.29.2]:11965 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263644AbUDUTYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 15:24:35 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: booting problem!
Date: Wed, 21 Apr 2004 19:24:19 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c66hp3$5sv$1@terminus.zytor.com>
References: <4086424B.9070206@prodigylabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1082575459 6048 63.209.29.3 (21 Apr 2004 19:24:19 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 21 Apr 2004 19:24:19 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4086424B.9070206@prodigylabs.com>
By author:    manu <manu@prodigylabs.com>
In newsgroup: linux.dev.kernel
>
> hi all  iam new to this list.
> i am trying to install the linux without bootloader.
> i used dd  to write kernel image to /dev/hdc.
> but when i try to boot from it. it is saying
>  
>  Loading.
>  4000
>  AX:0208
>  BX:0200
>  CX:0002
>  DX:0000
>  4000
> iam using  2.4.22 kernel.
> 
> can anybody tell me whts the problem. when i tried same with /dev/fd0 (floppy) it  is booting fine.but i dont know
> whts the prolem with the compact flash,any ideas.
> 

The builtin boot sector can only be used to boot from legacy floppy
drives, not even USB or IDE floppy drives.  It's use is deprecated
(and removed in 2.6.)

Use a bootloader.

	-hpa
