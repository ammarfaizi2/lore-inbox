Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUA3Rl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUA3RjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:39:09 -0500
Received: from gprs116-76.eurotel.cz ([160.218.116.76]:46209 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263290AbUA3RiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:38:24 -0500
Date: Fri, 30 Jan 2004 18:06:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>
Cc: azz@us-lot.org, linux-kernel@vger.kernel.org
Subject: Re: Userspace filesystems (WAS: Encrypted Filesystem)
Message-ID: <20040130170610.GB625@elf.ucw.cz>
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com> <y2ar7xmkyqe.fsf@cartman.at.fivegeeks.net> <200401281350.i0SDo2I03247@duna48.eth.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401281350.i0SDo2I03247@duna48.eth.ericsson.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  2) This one is harder to get rid of, especially because I don't want
>     to delve into the technical merits of one or the other (I'd be a
>     bit biased).  But I have compared both the kernel interface and
>     the library API of LUFS and FUSE and they are very similar.  And
>     that is a good thing, because it makes possible to support LUFS
>     filesystems with the FUSE kernel module and vica versa.

Jean-Luc wrote:
>    app wants to read data from a file ->
>    userspace application requires memory allocation to provide this data ->
>    VM tries to write out dirty data associated with the Coda mountpoint ==
>    deadlock

How do you solve this one?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
