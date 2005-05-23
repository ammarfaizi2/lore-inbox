Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVEWRkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVEWRkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 13:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVEWRjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 13:39:55 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:8377 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261918AbVEWRbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 13:31:10 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net, eric.begot@gmail.com
Subject: Re: [uml-devel] [PATCH] UML - 2.6.12-rc4-mm2 Compile error
Date: Mon, 23 May 2005 19:32:47 +0200
User-Agent: KMail/1.7.2
Cc: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org> <4290E1C6.9070709@gmail.com>
In-Reply-To: <4290E1C6.9070709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505231932.48146.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 May 2005 21:47, Eric BEGOT wrote:
> Here is a patch to correct a compile error on linux 2.6.12-rc4-mm2 for uml.
> At the compilation of init/main.c, it complains because it doens't find
> the 2 constants FIXADDR_USER_START and FIXADDR_USER_END
On mainline it's defined by either include/asm-um/archparam-x86_64.h or 
include/asm-um/elf-i386.h.

Make sure you used a clean tree and a correct command line (make init/main.o 
ARCH=um wouldn't work because it would not create the needed header 
symlinks).
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

