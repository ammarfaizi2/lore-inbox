Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316265AbSEZSlM>; Sun, 26 May 2002 14:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316264AbSEZSlL>; Sun, 26 May 2002 14:41:11 -0400
Received: from ns.suse.de ([213.95.15.193]:21767 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316263AbSEZSlJ>;
	Sun, 26 May 2002 14:41:09 -0400
Date: Sun, 26 May 2002 20:41:09 +0200
From: Dave Jones <davej@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: trivial: pcnet32 whitespace
Message-ID: <20020526204109.K16102@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>
In-Reply-To: <20020526183056.GA10669@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 08:30:56PM +0200, Pavel Machek wrote:
 > - *  compile-command: "gcc -D__KERNEL__ -I/usr/src/linux/net/inet -Wall -Wstrict-prototypes -O6 -m486 -c pcnet32.c"
 > + *  compile-command: "gcc -D__KERNEL__ -I/usr/src/linux/include/linux -Wall -Wstrict-prototypes -O2 -m486 -c pcnet32.c"

Better would be to not have an absolute path in there at all.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
