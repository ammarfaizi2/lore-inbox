Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbUJ0Q3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbUJ0Q3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbUJ0Q2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:28:46 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:28696 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262512AbUJ0QWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:22:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nMoWPEqMEhi3X90pKaXchY8ETNK27hn5N4hC0aRlwI8RmnJvtt2x24ewv+FB2hL/v3OLombNPQqOFopD9qjw/WfnHjddB9nasvdoZZqdnjnUM4Kr634ZZqSDnYjEQIX13EHWjGsKXIviRsP/lSxNoI0SugFAwrgpCL736s569Bc=
Message-ID: <58cb370e04102709221d6a9103@mail.gmail.com>
Date: Wed, 27 Oct 2004 18:22:04 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: gene.heskett@verizon.net
Subject: Re: [BK PATCHES] ide-2.6 update
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, linux-ide@vger.kernel.org
In-Reply-To: <200410271215.55472.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <58cb370e04102706074c20d6d7@mail.gmail.com>
	 <200410271215.55472.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 12:15:55 -0400, Gene Heskett
<gene.heskett@verizon.net> wrote:
> On Wednesday 27 October 2004 09:07, Bartlomiej Zolnierkiewicz wrote:
> >Please do a
> >
> > bk pull bk://bart.bkbits.net/ide-2.6
> >
> >This will update the following files:
> >
> > drivers/ide/ide-disk.c         |    1 +
> > drivers/ide/ide-dma.c          |   32
> 
> Even after fixing the 4 wrapped lines in the patch, I'm not going in
> cleanly here:
> 
> patching file drivers/ide/ide-dma.c
> Hunk #1 FAILED at 681.
> 1 out of 1 hunk FAILED -- saving rejects to file
> drivers/ide/ide-dma.c.rej
> 
> The first 'grep' line of the patch is found at an offset of about +180
> lines in the original file.
> 
> The rest of it seems to have found a home, but at offsets in excess of
> 159 lines for a few of them.
> 
> This was against a 2.6.9 tree, and 2.6.9-mm1 failed in similar
> fashion.  What src tree is this to be applied to?

current linus' -bk tree, latest -bk snapshot should also be OK
