Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269764AbRHDCte>; Fri, 3 Aug 2001 22:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269765AbRHDCtY>; Fri, 3 Aug 2001 22:49:24 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:55307 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269764AbRHDCtQ>;
	Fri, 3 Aug 2001 22:49:16 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <laughing@shared-source.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac5 
In-Reply-To: Your message of "Fri, 03 Aug 2001 23:41:02 +0100."
             <20010803234102.A15863@lightning.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 Aug 2001 12:49:18 +1000
Message-ID: <24967.996893358@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001 23:41:02 +0100, 
Alan Cox <laughing@shared-source.org> wrote:
>2.4.7ac5

Please remove kernel.spec from your patches.  It is already out of
date, the version in your patch is 2.4.7-ac3, not ac5.  Including a
generated and dynamic file in the shipped kernel only works if the
patch maintainer remembers to generate it every time.

If somebody wants the kernel.spec file they can make spec and pick up
their own kernel version.  In any case, they will probably want to add
patches and set EXTRAVERSION so a prebuilt kernel.spec is again out of
date.

