Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269207AbRHLOgx>; Sun, 12 Aug 2001 10:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269242AbRHLOgo>; Sun, 12 Aug 2001 10:36:44 -0400
Received: from t2.redhat.com ([199.183.24.243]:5874 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S269207AbRHLOgc>; Sun, 12 Aug 2001 10:36:32 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <4736.997579282@ocs3.ocs-net> 
In-Reply-To: <4736.997579282@ocs3.ocs-net> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Tom Rini <trini@kernel.crashing.org>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Aug 2001 15:36:13 +0100
Message-ID: <21485.997626973@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  The alternative of having code in some arch directory updating
> include/asm-$(ARCH)/offsets.h is worse.  It is a terrible design to
> have code in one makefile updating files in another directory.  It is
> a layer violation which is always a bad idea.

With sensible (i.e. non-recursive) makefiles, surely this is far more 
acceptable?

--
dwmw2


