Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283719AbRLOVcb>; Sat, 15 Dec 2001 16:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283770AbRLOVcM>; Sat, 15 Dec 2001 16:32:12 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:5455 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S283719AbRLOVb4>; Sat, 15 Dec 2001 16:31:56 -0500
Date: Sat, 15 Dec 2001 23:31:34 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4GB file size limit on SMBFS
Message-ID: <20011215233133.I12063@niksula.cs.hut.fi>
In-Reply-To: <3C19A3CC.7020501@century.cz> <Pine.LNX.4.33.0112151705010.12939-100000@cola.teststation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112151705010.12939-100000@cola.teststation.com>; from urban@teststation.com on Sat, Dec 15, 2001 at 10:02:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2001 at 10:02:00PM +0100, you [Urban Widmark] claimed:
> On Fri, 14 Dec 2001, Petr Titera wrote:
> 
> The first patch was incomplete. It contained a calculation bug on the
> smbfs side limiting the possible offset to 32bits unsigned.
> 
> New patch vs 2.4.16 (and others) available here:
>     http://www.hojdpunkten.ac.se/054/samba/lfs.html

BTW: the fsx test Dave Jones just pointed out pretty quickly fails on smbfs
on 2.4.8ac2 (mounting a share from NT4SP6a). I don't have anything never to
play with just now (1), but if you can't immediately reproduce it, I can
compile a newer kernel for the left over box and give it a longer whirl.


-- v --

v@iki.fi

(1) I have a 2.4.16/ia64 on the corner, but fsx fails on IA64 with any fs
    ("mmap: Invalid argument"). Smbfs seems to work on ia64 otherwise...
