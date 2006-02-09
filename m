Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWBIVyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWBIVyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 16:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWBIVyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 16:54:09 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:54934 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750724AbWBIVyI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 16:54:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r+6pOcSAUIbSOBDpquogWMWyTbDvp/o3F4FjuQUy0fTdsUM1ZD9E8aXFsyap6knelFkxkP3NmJKYZ34ZI+eoTNIA2JpBJ/67wlYaNTIXlCqf0HL91WO5Vs3DIdWID4svaLgiSkGYMefflKzeM1yxf2eMfSA5/gPxzvQ5xbByFJU=
Message-ID: <728201270602091354r7bc145c7i35e0b90ebf3d3af4@mail.gmail.com>
Date: Thu, 9 Feb 2006 15:54:03 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: kapil a <kapilann@gmail.com>
Subject: Re: file system question
Cc: Avishay Traeger <atraeger@cs.sunysb.edu>, lloyd@randombit.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <ef2d59350602090957o1a86757fk31c361e2e37f1e1f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ef2d59350602081539w7b6780e3mf6d8326f6d4963f2@mail.gmail.com>
	 <1139443268.4902.11.camel@rockstar.fsl.cs.sunysb.edu>
	 <ef2d59350602081611h4492bf47ne24e3d591efd29e7@mail.gmail.com>
	 <1139447727.4902.13.camel@rockstar.fsl.cs.sunysb.edu>
	 <ef2d59350602090957o1a86757fk31c361e2e37f1e1f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/06, kapil a <kapilann@gmail.com> wrote:
> I am only sending the relevant stuff.
>
> My strace output :
>
> fstat64(3, {st_mode=S_IFDIR|0755, st_size=48, ...}) = 0
> fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
> getdents64(3, /* 3 entries */, 4096)    = 80
> getdents64(3, /* 0 entries */, 4096)    = 0
> close(3)                                = 0
> exit_group(0)
>
> strace output on a partition under ext2
>
> fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
> getdents64(3, /* 4 entries */, 4096)    = 104
> getdents64(3, /* 0 entries */, 4096)    = 0


Why dont you write a simple program which makes call to
open,read,write & others you want to test. That  would not make these
unnecessary  calls.

Regards
Ram Gupta
