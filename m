Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSEQCYj>; Thu, 16 May 2002 22:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSEQCYi>; Thu, 16 May 2002 22:24:38 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:2314
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315334AbSEQCYh>; Thu, 16 May 2002 22:24:37 -0400
Date: Thu, 16 May 2002 19:24:10 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre8
Message-ID: <20020517022410.GA627@matchmail.com>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0205021845430.10896-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in
/src/2.4.19-pre8/debian/tmp-image/lib/modules/2.4.19-pre8/kernel/drivers/char/drm/sis.o
depmod:         sis_free
depmod:         sis_malloc

So setting:

CONFIG_AGP_SIS=n

This has been there for a while IIRC.
