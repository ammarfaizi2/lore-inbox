Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269287AbRHLO4f>; Sun, 12 Aug 2001 10:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269288AbRHLO40>; Sun, 12 Aug 2001 10:56:26 -0400
Received: from t2.redhat.com ([199.183.24.243]:6898 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S269287AbRHLO4J>; Sun, 12 Aug 2001 10:56:09 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3742.997627694@ocs3.ocs-net> 
In-Reply-To: <3742.997627694@ocs3.ocs-net> 
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Aug 2001 15:56:07 +0100
Message-ID: <21969.997628167@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  If you allow creation of a file in one directory but storing it in
> another then you have to search all makefiles to find out what is
> created in any directory.  Horrible!

Fine. But what's stopping us from putting a makefile in the 
asm-$(ARCH)/include directory? There are already automatically generated 
files in there. What have you already done for stuff like 
asm-arm/mach-types.h?


--
dwmw2


