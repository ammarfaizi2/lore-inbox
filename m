Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSEMCNi>; Sun, 12 May 2002 22:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315478AbSEMCNh>; Sun, 12 May 2002 22:13:37 -0400
Received: from rj.SGI.COM ([192.82.208.96]:58269 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315472AbSEMCNh>;
	Sun, 12 May 2002 22:13:37 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: khromy@lnuxlab.ath.cx (khromy)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre8-ac2 kbuild 2.4 tmp_include_depends 
In-Reply-To: Your message of "Sun, 12 May 2002 22:10:34 -0400."
             <20020513021034.GA19904@lnuxlab.ath.cx> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 May 2002 12:13:24 +1000
Message-ID: <28713.1021256004@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002 22:10:34 -0400, 
khromy@lnuxlab.ath.cx (khromy) wrote:
>After applying the patch pre8-ac2 still doesn't compile.
>
>make dep
>[no errors]
>make bzImage
>gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
>scripts/split-include scripts/split-include.c
>make: *** No rule to make target `include/linux/autoconf.h', needed by
>`include/config/MARKER'.  Stop.

You forgot make *config.

