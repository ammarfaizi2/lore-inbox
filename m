Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVCRR3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVCRR3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 12:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVCRR3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 12:29:31 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:14828 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262001AbVCRR30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 12:29:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=krnJHdQsQ4/oz5u3PHxp+KJd+sk+NMrryPJJ6lq7TPw42wBNUmjF/Ln3Ue92S1zmEUsaJTnQtc5Q8TtqqZUQM4ogXz1C+QePZRQCmG2kmxyuegBoD6TsHf+CS7gG0qb7AIMJkEMSzdD76VMZ/hO9JNkTTNqCfXhkydF4+nP3Ezs=
Message-ID: <58cb370e0503180929716ffea3@mail.gmail.com>
Date: Fri, 18 Mar 2005 18:29:25 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: lkml@think-future.de, Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Buffer I/O error on device hdg1, system freeze.
In-Reply-To: <20050318152952.7657144FBE@service.i-think-future.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050318152952.7657144FBE@service.i-think-future.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005 16:29:45 +0100, lkml@think-future.de
<lkml@think-future.de> wrote:
> 
> 
> One line summary of the problem:
> Buffer I/O error on device hdg1, system freeze.
> 
> Full description of the problem/report:
>  the following error showed up in dmesg today:
> 
>  hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>  hdg: dma_intr: error=0x40 { UncorrectableError }, LBAsect=262311, high=0, low=262311, sector=262311
>  ide: failed opcode was: unknown
>  end_request: I/O error, dev hdg, sector 262311
>  Buffer I/O error on device hdg1, logical block 131124
> 
>   fscking this disk freezes the entire system.
> 
>  The disk was remounted ro afterwards.
>  Disk itself is ok. Is a new one.

I doubt it, you can verify this with:
http://smartmontools.sf.net
