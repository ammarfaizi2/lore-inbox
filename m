Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUBRUyh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUBRUyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:54:37 -0500
Received: from node-402418b2.mdw.onnet.us.uu.net ([64.36.24.178]:38642 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S268077AbUBRUye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:54:34 -0500
Date: Wed, 18 Feb 2004 14:52:06 -0600
From: Brandon Low <lostlogic@gentoo.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
Message-ID: <20040218205206.GD449@lostlogicx.com>
References: <20040217232130.61667965.akpm@osdl.org> <40338FE8.60809@tmr.com> <20040218200439.GB449@lostlogicx.com> <20040218122216.62bb9e82.akpm@osdl.org> <20040218203325.GC449@lostlogicx.com> <20040218125227.0bf7dc2f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218125227.0bf7dc2f.akpm@osdl.org>
X-Operating-System: Linux found.lostlogicx.com 2.6.1-mm2
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02/18/04 at 12:52:27 -0800, Andrew Morton wrote:
> Brandon Low <lostlogic@gentoo.org> wrote:
> >
> > but if people are depending on that support to stay
> >  in a stable kernel and are developing based on it and don't have the
> >  time to learn dm or dmcrypto and redesign whatever may need redesigning
> >  to use it, it strikes me as rude to pull that support.
> 
> This is actually an argument for removing cryptolooop.  People are
> developing against a crypto infrastructure which has well-known weaknesses.
> 
> Pulling it out is an excellent way of communicating this fact.  Right now,
> we're just deluding people.

Unfortunately, you have a valid point... I don't like it, because it
means work for me, but it is a valid point... 

I am just reading up on dm now, but correct me if I am wrong, I will
need to do losetup, dmcreate, mount in that order in order to use
dmcrypt on loop where with cryptoloop, I could just do "mount"... there
must be an easier way to handle this!

Thanks,

Brandon
