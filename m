Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263407AbRFRXp4>; Mon, 18 Jun 2001 19:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263427AbRFRXpq>; Mon, 18 Jun 2001 19:45:46 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:57561 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263407AbRFRXpc>;
	Mon, 18 Jun 2001 19:45:32 -0400
Date: Mon, 18 Jun 2001 19:45:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Timur Tabi <ttabi@interactivesi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: What happened to lookup_dentry?
In-Reply-To: <PD1Rx.A.X-F.-YnL7@dinero.interactivesi.com>
Message-ID: <Pine.GSO.4.21.0106181940400.18769-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Jun 2001, Timur Tabi wrote:

> I'm porting a driver from 2.2 to 2.4, and this driver calls lookup_dentry,
> which doesn't exist in 2.4.  I've read through the source code and searched the
> web and newsgroups, and I can't find any explanation as to why lookup_dentry no
> longer exists or how I'm supposed to change code that uses it.  Can anyone help
> me?

It depends on what kind of use 2.2 code had for it. There are several
situations in which it used to be called and proper replacements depend
on the context. Details, please... (alternatively, send an URL of patch
and I'll see what to do with the thing)

