Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292522AbSBTVuS>; Wed, 20 Feb 2002 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292525AbSBTVuI>; Wed, 20 Feb 2002 16:50:08 -0500
Received: from quark.didntduck.org ([216.43.55.190]:24331 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S292522AbSBTVtv>; Wed, 20 Feb 2002 16:49:51 -0500
Message-ID: <3C7419F7.A441CAFC@didntduck.org>
Date: Wed, 20 Feb 2002 16:49:43 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Yan <jasonyanjk@yahoo.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: initialize page tables --  Re: paging question
In-Reply-To: <20020220213724.SKHN4996.tomts12-srv.bellnexxia.net@abc337>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Yan wrote:
> 
> Thank you all.
> 
> OK. I got it. and,
> 
> Is the linker who set the beginning virtual address as 0xc0100000 ? Is it a must? When and where? at the time "make bzImage" ?  If it's not a BIG kernel, is the magic number still 0xc0100000 ?

It's set in vmlinux.lds, and is the same for all kernels unless patched
to change the user:kernel vm split.

--

				Brian Gerst
