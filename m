Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271744AbTG2Njj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271746AbTG2Nji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:39:38 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:23788 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S271744AbTG2Njh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:39:37 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 29 Jul 2003 15:39:25 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Framebuffer: client notification mecanism & PM
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <89CD6530893@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 03 at 9:13, Benjamin Herrenschmidt wrote:
> +++ linuxppc-2.5-benh/drivers/video/fbmem.c 2003-07-23 20:05:02.000000000 -0400
> @@ -143,6 +143,8 @@
>  extern int sstfb_setup(char*);
>  extern int i810fb_init(void);
>  extern int i810fb_setup(char*);
> +extern int ibmlcdfb_init(void);
> +extern int ibmlcdfb_setup(char*);
>  extern int ffb_init(void);
>  extern int ffb_setup(char*);
>  extern int cg6_init(void);

Oops... You probably did not want IBM LCD diffs in fbmem.c posted.

matroxfb tried to use a 'dead' for handling hot removal, but your code
looks definitely saner.
                                                Petr

