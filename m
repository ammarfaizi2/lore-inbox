Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbTE0T3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264092AbTE0T3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:29:06 -0400
Received: from uldns1.unil.ch ([130.223.8.20]:42985 "EHLO uldns1.unil.ch")
	by vger.kernel.org with ESMTP id S264091AbTE0T3D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:29:03 -0400
Date: Tue, 27 May 2003 21:42:08 +0200
From: Gregoire Favre <greg@magma.unil.ch>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: xfs don't compil in linux-2.5 BK
Message-ID: <20030527194208.GC17428@magma.unil.ch>
References: <20030526193136.GB10276@magma.unil.ch> <1053986469.3754.6.camel@nalesnik.localhost> <20030526223803.GB14954@magma.unil.ch> <3ED2A8B2.5040607@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3ED2A8B2.5040607@gmx.net>
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 01:52:18AM +0200, Carl-Daniel Hailfinger wrote:

> if you are using bk, maybe not all files were checked out? Try
> 
> bk -r get
> 
> and if the error still does not go away,
> 
> make mrproper
> 
> and then
> 
> make {,x,menu}config
> 
> make dep does nothing in 2.5 and make bzImage is standard target, so you
> can abbreviate you command line to
> 
> make && make modules && sudo make modules_install

Thank you very much for your answer, I have tried the bk -r get, but I
didn't get the 2.5.70 in the Makefile...
I am a little bit lost with bk. Finally I tried:
bk pull
bk -r co

And then I got the 2.5.70 and it still compiling it ;-)
(the xfs stuff is passed).

Sorry for the complete off-topic: I use DVB, and most of the time, the
one included in the kernel is outdated and I took the one from
cvs -q -z3 -d :pserver:anonymous@linuxtv.org:/cvs/linuxtv co dvb-kernel
and the dvb-kernel/makelinks replace some files from the kernel with
symlinks: could I then use bk to update after?

An hudge thank,

	Grégoire
__________________________________________________________________
http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch
