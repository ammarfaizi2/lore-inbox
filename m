Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269006AbUIBUWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269006AbUIBUWF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268988AbUIBUUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:20:42 -0400
Received: from the-village.bc.nu ([81.2.110.252]:20113 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268970AbUIBUT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:19:56 -0400
Subject: Re: silent semantic changes with reiser4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@ucw.cz>, Spam <spam@tnonline.net>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <1094155277.11364.92.camel@krustophenia.net>
References: <rlrevell@joe-job.com>
	 <1094079071.1343.25.camel@krustophenia.net>
	 <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl>
	 <1535878866.20040902214144@tnonline.net>
	 <20040902194909.GA8653@atrey.karlin.mff.cuni.cz>
	 <1094155277.11364.92.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094152590.5726.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 20:16:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 21:01, Lee Revell wrote:
> But is it efficient to make every application that reads files have to
> know how to get inside a tar file, just to read its contents?  That
> seems like a massive duplication of effort.  Better to have the contents
> accessible via a separate stream, in the same namespace.  Fix it once in
> the kernel vs. fix it in umpteen apps.

Thats how you get yourself a non useful OS. Fix it in a library and
share it between the apps that care. Like say.. gnome-vfs2

