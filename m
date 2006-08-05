Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWHFV7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWHFV7z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 17:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWHFV7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 17:59:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39437 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750727AbWHFV7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 17:59:54 -0400
Date: Sat, 5 Aug 2006 21:05:52 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       tytso@mit.edu, tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-ID: <20060805210552.GD5417@ucw.cz>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI> <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com> <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI> <1154021616.13509.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154021616.13509.68.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Sure. Though I wonder if sys_frevoke is enough for us and we can drop 
> > sys_revoke completely.
> 
> Alas not. Some Unix devices have side effects when you open() them. 

We probably want some other solution for those, anyway...? Like
open(..., O_NONE)?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
