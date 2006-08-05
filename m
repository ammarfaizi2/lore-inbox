Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWHFWCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWHFWCf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWHFWCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:02:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49933 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750732AbWHFWCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:02:10 -0400
Date: Sat, 5 Aug 2006 12:29:37 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, alan@lxorguk.ukuu.org.uk, tytso@mit.edu,
       tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-ID: <20060805122936.GC5417@ucw.cz>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch implements the revoke(2) and frevoke(2) system calls for
> all types of files. The operation is done in passes: first we replace


Do we need revoke()? open()+frevoke() should be fast enough, no?
-- 
Thanks for all the (sleeping) penguins.
