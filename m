Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSEGSz0>; Tue, 7 May 2002 14:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315943AbSEGSzZ>; Tue, 7 May 2002 14:55:25 -0400
Received: from ns.suse.de ([213.95.15.193]:60945 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315942AbSEGSzY>;
	Tue, 7 May 2002 14:55:24 -0400
Date: Tue, 7 May 2002 20:55:23 +0200
From: Dave Jones <davej@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.14-dj1: misc.o: undefined reference to `__io_virt_debug'
Message-ID: <20020507205523.D12134@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0205071923460.9347-200000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 08:36:09PM +0200, Adrian Bunk wrote:

 > misc.o: In function `puts':
 > misc.o(.text+0x1c46): undefined reference to `__io_virt_debug'
 > misc.o(.text+0x1c7c): undefined reference to `__io_virt_debug'
 > misc.o(.text+0x1ca9): undefined reference to `__io_virt_debug'
 > misc.o(.text+0x1cde): undefined reference to `__io_virt_debug'

Odd. Repeatable after a make distclean ?
I always build my test kernels with CONFIG_DEBUG_IOVIRT=y, and I
haven't seen this happen.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
