Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWHUV4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWHUV4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWHUV4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:56:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55566 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751222AbWHUV4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:56:41 -0400
Date: Mon, 21 Aug 2006 23:56:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: arch/um/sys-i386/setjmp.S: useless #ifdef _REGPARM's?
Message-ID: <20060821215641.GQ11651@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/um/sys-i386/setjmp.S contains two #ifdef _REGPARM's.

Even if regparm was used in i386 uml (which isn't currently done (why?)),
I don't see _REGPARM being defined anywhere.

Is this a bug waiting for happening when regparm will be used on uml or 
do I miss anything?

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

