Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbULRRKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbULRRKg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 12:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbULRRKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 12:10:35 -0500
Received: from eta.fastwebnet.it ([213.140.2.50]:42437 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261201AbULRRIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 12:08:44 -0500
Date: Sat, 18 Dec 2004 18:11:02 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Joseph Seigh" <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does atomic_read actually do?
Message-Id: <20041218181102.69c37e84@tux.homenet>
In-Reply-To: <opsi7o5nqfs29e3l@grunion>
References: <opsi7o5nqfs29e3l@grunion>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2004 11:23:37 -0500
"Joseph Seigh" <jseigh_02@xemaps.com> wrote:

> It doesn't do anything that would actually guarantee that the fetch
> from memory would be atomic as far as I can see, at least in the x86
> version. The C standard has nothing to say about atomicity w.r.t.
> multithreading or multiprocessing.  Is this a gcc compiler thing?  If
> so, does gcc guarantee that it will fetch aligned ints with a single
> instruction on all platforms or just x86?   And what's with volatile
> since if the C standard implies nothing about multithreading then it
> follows that volatile has no meaning with respect to multithreading
> either?  Also a gcc thing?  Are volatile semantics well defined enough
> that you can use it to make the compiler synchronize memory state as
> far as it is concerned?

http://www.gnu.org/software/libc/manual/html_node/Atomic-Data-Access.html#Atomic%20Data%20Access

http://www.gnu.org/software/libc/manual/html_node/Atomic-Types.html#Atomic%20Types

http://gcc.gnu.org/onlinedocs/gcc/Volatiles.html

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.9-gentoo-r6)
