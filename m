Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287544AbRLaPnQ>; Mon, 31 Dec 2001 10:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287553AbRLaPnG>; Mon, 31 Dec 2001 10:43:06 -0500
Received: from oss.sgi.com ([216.32.174.27]:27368 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S287552AbRLaPnB>;
	Mon, 31 Dec 2001 10:43:01 -0500
Date: Sun, 30 Dec 2001 23:59:39 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] global errno considered harmful
Message-ID: <20011230235939.A16384@dea.linux-mips.net>
In-Reply-To: <20011230110623.A17083@gnu.org> <200112301956.OAA02630@ccure.karaya.com> <20011230190020.A14157@dea.linux-mips.net> <3C2F90E1.DADE7F54@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C2F90E1.DADE7F54@didntduck.org>; from bgerst@didntduck.org on Sun, Dec 30, 2001 at 05:10:41PM -0500
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 05:10:41PM -0500, Brian Gerst wrote:

> > As user application are trying to use unistd.h and expect errno to get
> > set properly unistd.h or at least it's syscallX macros will have to be
> > made unusable from userspace or silent breakage of such apps rebuild
> > against new headers will occur.
> 
> Userspace should be using glibc's unistd.h.  If it's using the kernel's,
> it's broken.

A sufficient number take the unavailability of new syscall in everybody's
glibc as a sufficient excuse for broken code.  util-linux as a major
offender comes to mind or also e2fsprogs.

  Ralf
