Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283234AbRLIJEy>; Sun, 9 Dec 2001 04:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283233AbRLIJEq>; Sun, 9 Dec 2001 04:04:46 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:6924 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283244AbRLIJEd>;
	Sun, 9 Dec 2001 04:04:33 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.9.6 is available 
In-Reply-To: Your message of "Sun, 09 Dec 2001 03:32:49 CDT."
             <20011209033249.A28867@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Dec 2001 20:04:20 +1100
Message-ID: <19176.1007888660@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a quick check it looks good.

One niggle, some strings for kuild 2.5 are longer than 30 characters,
cml2 restricts the string length in make menuconfig.  Only menuconfig
has this restriction, not oldconfig nor xconfig.  Can the limit be
removed, or at least changed to $ROWS-n which would adjust to screen
size?

