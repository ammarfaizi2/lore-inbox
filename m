Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSHHSnZ>; Thu, 8 Aug 2002 14:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317874AbSHHSmT>; Thu, 8 Aug 2002 14:42:19 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:37615 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317877AbSHHSl7>; Thu, 8 Aug 2002 14:41:59 -0400
Subject: Re: parse error in ext2_fs_sb.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rik van Ballegooijen <sleightofmind@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D52B914.8050007@xs4all.nl>
References: <3D52B914.8050007@xs4all.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 21:05:44 +0100
Message-Id: <1028837144.28882.79.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 19:31, Rik van Ballegooijen wrote:
> When i was compiling some stuff, i got this error:
> 
> Parse error before "u32"
> 
> in the file (2.5.30):
> 
> include/linux/ext2_fs_sb.h
> 
> I changed the u32 to __u32 and it worked. Is this a (proper) solution?

u32 is used for stuff that shouldnt be visible to user space, only __u32
is available from user space. Are you building kernel code or user code
?

