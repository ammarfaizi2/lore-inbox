Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266173AbSL1Sy0>; Sat, 28 Dec 2002 13:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266285AbSL1Sy0>; Sat, 28 Dec 2002 13:54:26 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:55307 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S266173AbSL1Sy0>; Sat, 28 Dec 2002 13:54:26 -0500
Date: Sat, 28 Dec 2002 12:00:51 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Sam Ravnborg <sam@ravnborg.org>, gibbs@adaptec.com,
       Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [aic7xxx] Spurious recompile with defconfig
Message-ID: <698528112.1041102051@aslan.scsiguy.com>
In-Reply-To: <20021228085631.GA1835@mars.ravnborg.org>
References: <20021228085631.GA1835@mars.ravnborg.org>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When compiling aic7xxx in 2.5.53 with defconfig the kernel always
> recompiles because dependency for reg_print.c is not
> per default in the aic7xxx Makefile.
> Simple correction is to make PRETTY_PRINT dependend on BUILD_FIRMWARE.

There must be some other problem in the Makefile.  You can turn on
reg pretty printing without having to build the firmware as there is
a "shipped" version of that file.  I'll see if I can figure out why the
re-build is occurring.

--
Justin

