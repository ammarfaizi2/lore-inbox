Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265216AbUBOX2S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 18:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbUBOX2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 18:28:18 -0500
Received: from amalthea.dnx.de ([193.108.181.146]:12524 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S265216AbUBOX2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 18:28:17 -0500
Date: Mon, 16 Feb 2004 00:28:11 +0100
From: Robert Schwebel <robert@schwebel.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Cross Compiling
Message-ID: <20040215232810.GK549@pengutronix.de>
References: <402D9567.B5044EFE@ou.edu> <20040214142157.GA9398@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040214142157.GA9398@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Spam-Score: 0.0 (/)
X-Scan-Signature: 346b5eef83b54e7774ba8be021db0e74
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert, 

On Sat, Feb 14, 2004 at 03:21:57PM +0100, Herbert Poetzl wrote:
> > http://kegel.com/crosstool
> 
> thanks for the info, I read/tested that one too, some time
> ago, but decided against this approach, as it builds the
> glibc, which I do not need for the kernel toolchain at all
> and I didn't want to bother with another source that won't
> compile on arch xy ... maybe the wrong decision? I don't 
> know ...

you might also want to have a look at the idea behind PTXdist (see
http://www.pengutronix.de/software/ptxdist_en.html) which is also able
to build toolchains and do all the necessary tweaking, without building
a glibc (just only run 'make xchain-gccstage1' to get a compiler without
glibc). It follows the same approach for the patch repositories like Dan
and we are syncing heavily.

The whole toolchain building is a huge mess at the moment.  

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
