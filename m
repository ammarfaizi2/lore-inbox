Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUGSNwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUGSNwD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 09:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUGSNwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 09:52:03 -0400
Received: from penguin.linuxhardware.org ([63.173.68.170]:31714 "EHLO
	penguin.linuxhardware.org") by vger.kernel.org with ESMTP
	id S265255AbUGSNv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 09:51:59 -0400
Date: Mon, 19 Jul 2004 09:57:41 -0400 (EDT)
From: augustus@linuxhardware.org
To: Ciaran McCreesh <ciaranm@gentoo.org>
Cc: linux-kernel@vger.kernel.org, tseng@gentoo.org,
       jnagyjr@joseph-a-nagy-jr.homelinux.org
Subject: Re: vim doesn't like the command line
In-Reply-To: <20040717233654.102579e1@snowdrop.home>
Message-ID: <Pine.LNX.4.58.0407190956070.29213@penguin.linuxhardware.org>
References: <Pine.LNX.4.58.0407142340560.7017@penguin.linuxhardware.org>
 <20040717233654.102579e1@snowdrop.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for that link.  I'll see if I can produce anything helpful.  This 
is an odd one but it may be header related.  Someone (possibly me), should 
try building using the 2.6.8-r1 headers.  The odd thing here though is 
that vim is the only app that seems to be affected.  Got any others?

Thanks,
Kris Kersey (Augustus)
LinuxHardware.org Site Manager
augustus@linuxhardware.org
Gentoo Linux AMD64 Developer
augustus@gentoo.org

On Sat, 17 Jul 2004, Ciaran McCreesh wrote:

> On Wed, 14 Jul 2004 23:44:16 -0400 (EDT) augustus@linuxhardware.org
> wrote:
> | This is odd but it seems that vim 6.3 does not function properly with 
> | kernel 2.6.8-rc1.  It will not take command line arguement filenames. 
> | No matter what you pass it, it always goes to the file browser.  This
> | is not the case with 2.6.7 kernels.  Any ideas?  I have attached my
> | kernel .config.
> 
> I've been trying to track this down as well. Kinda tricky, since it
> WORKSFORME(TM). The following may be of help to you:
> 
> http://bugs.gentoo.org/show_bug.cgi?id=57378
> 
> Basically, argv is getting nuked by something.
> 
> Seems rebuilding without a -march in CFLAGS fixes it for some people,
> reason unknown...
> 
> -- 
> Ciaran McCreesh : Gentoo Developer (Sparc, MIPS, Vim, Fluxbox)
> Mail            : ciaranm at gentoo.org
> Web             : http://dev.gentoo.org/~ciaranm
> 
> 
