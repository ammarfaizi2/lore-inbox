Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUFDPHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUFDPHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUFDPGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:06:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31206 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265760AbUFDPF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:05:57 -0400
Date: Fri, 4 Jun 2004 17:05:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc2-mm2: compile error with VIDEO_CX88=y and gcc 2.95
Message-ID: <20040604150548.GA7744@fs.tum.de>
References: <20040603015356.709813e9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603015356.709813e9.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

The following compile error with CONFIG_VIDEO_CX88=y when using gcc 2.95
is still present in both 2.6.7-rc2 and 2.6.7-rc2-mm2:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x372a76): In function `set_tvaudio':
: undefined reference to `__ucmpdi2'
drivers/built-in.o(.text+0x372a90): In function `set_tvaudio':
: undefined reference to `__ucmpdi2'
drivers/built-in.o(.text+0x372aa3): In function `set_tvaudio':
: undefined reference to `__ucmpdi2'
drivers/built-in.o(.text+0x372aba): In function `set_tvaudio':
: undefined reference to `__ucmpdi2'
drivers/built-in.o(.text+0x372ada): In function `set_tvaudio':
: undefined reference to `__ucmpdi2'
drivers/built-in.o(.text+0x372af4): more undefined references to 
`__ucmpdi2' follow
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

