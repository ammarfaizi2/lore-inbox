Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTJ3LV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 06:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTJ3LV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 06:21:57 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:32263 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262373AbTJ3LVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 06:21:55 -0500
Subject: Re: Things that Longhorn seems to be doing right
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Erik Andersen <andersen@codepoet.org>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20031030015212.GD8689@thunk.org>
References: <3F9F7F66.9060008@namesys.com>
	 <20031029224230.GA32463@codepoet.org>  <20031030015212.GD8689@thunk.org>
Content-Type: text/plain
Message-Id: <1067512910.1228.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 30 Oct 2003 12:21:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-30 at 02:52, Theodore Ts'o wrote:
> Keep in mind that just because Windows does thing a certain way
> doesn't mean we have to provide the same functionality in exactly the
> same way.
> 
> Also keep in mind that Microsoft very deliberately blurs what they do
> in their "kernel" versus what they provide via system libraries (i.e.,
> API's provided via their DLL's, or shared libraries).
> 
> At some level what they have done can be very easily replicated by
> having a userspace database which is tied to the filesystem so you can
> do select statements to search on metadata assocated with files.  We
> can do this simply by associating UUID's to files, and storing the
> file metadata in a MySQL database which can be searched via
> appropriate userspace libraries which we provide.
> 
> Please do **not** assume that just because of the vaporware press
> releases released by Microsoft that (a) they have pushed an SQL Query
> optimizer into the kernel, or that (b) even if they did, we should
> follow their bad example and attempt to do the same.  
> 
> There are multiple ways of skinning this particular cat, and we don't
> need to blindly follow Microsoft's design mistakes.
> 
> Fortunately, I have enough faith in Linus Torvalds' taste that I'm not
> particularly worried what would happen if someone were to send him a
> patch that attempted to cram MySQL or Postgres into the guts of the
> Linux kernel....  although I would like to watch when someone proposes
> such a thing!

In fact, the GNOME taskforce is already working on something much like
the much-touted-but-nearly-inexistent WinFS. It's all done in userspace:

http://www.gnome.org/~seth/storage/index.html

