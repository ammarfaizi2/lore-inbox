Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbSJIXRm>; Wed, 9 Oct 2002 19:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSJIXQ3>; Wed, 9 Oct 2002 19:16:29 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:45224 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263026AbSJIXPk>; Wed, 9 Oct 2002 19:15:40 -0400
Subject: Re: Why NFS server does not pass lock requests via VFS lock() op?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Juan Gomez <juang@us.ibm.com>
Cc: nfs@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <OF3AABFEC7.87E5D2A4-ON87256C4D.007E3028@us.ibm.com>
References: <OF3AABFEC7.87E5D2A4-ON87256C4D.007E3028@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Oct 2002 00:32:02 +0100
Message-Id: <1034206322.1970.105.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 00:11, Juan Gomez wrote:
> 
> 
> 
> 
> Could anyone remind me of why NFS kernel would not pass byte range lock
> requests to the underlying filsystem at the server side?
> I think another person at IBM (Brian?) submitted a patch for this but such
> patch never got included in the distribution.

I know Matthew had the patches, and I know I looked at them and they
seemed sane enough. But I don't know where they eventually went. Things
like NFS over AFS are going to need it

