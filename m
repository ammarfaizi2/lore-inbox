Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUBNOWA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 09:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbUBNOWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 09:22:00 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:37775 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261957AbUBNOV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 09:21:58 -0500
Date: Sat, 14 Feb 2004 15:21:57 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Stephen M. Kenton" <skenton@ou.edu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Cross Compiling
Message-ID: <20040214142157.GA9398@MAIL.13thfloor.at>
Mail-Followup-To: "Stephen M. Kenton" <skenton@ou.edu>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <402D9567.B5044EFE@ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402D9567.B5044EFE@ou.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 09:26:31PM -0600, Stephen M. Kenton wrote:
> The problems with GCC cross builds are known and are
> targeted for GCC 3.5 since the changes will apparently be
> invasive.  If you have not seen it yet, Dan Kegel has
> a very nice package called crosstool with lots of
> comments about the contortions of cross compiling.
> http://kegel.com/crosstool

thanks for the info, I read/tested that one too, some time
ago, but decided against this approach, as it builds the
glibc, which I do not need for the kernel toolchain at all
and I didn't want to bother with another source that won't
compile on arch xy ... maybe the wrong decision? I don't 
know ...

best,
Herbert

> smk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
