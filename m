Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965262AbWIJFfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965262AbWIJFfs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 01:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbWIJFfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 01:35:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39337 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965262AbWIJFfs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 01:35:48 -0400
Date: Sat, 9 Sep 2006 22:35:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Magnus =?ISO-8859-1?B?TeTkdHTk?= <novell@kiruna.se>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.6.18-rc6-mm1
Message-Id: <20060909223533.0bdcdc3f.akpm@osdl.org>
In-Reply-To: <200609100237.51822.novell@kiruna.se>
References: <200609091445.32744.novell@kiruna.se>
	<20060909112724.a214197b.akpm@osdl.org>
	<200609100237.51822.novell@kiruna.se>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Sep 2006 02:37:51 +0200
Magnus M‰‰tt‰ <novell@kiruna.se> wrote:

> > > EIP:    0060:[<c04ad300>]    Tainted: P      VLI
> >
> > What caused the taint?
> 
> I was pretty sure it was listed somewhere, but I guess it wasn't.
> nvidia graphics module, I can try without it tomorrow if needed.
> 

That would be appreciated thanks.

But first you'd need to ensure that it's a repeatable oops.  If
it's not, the removing the nvidia driver won't tell us if the nvidia
driver caused it.  (It almost certainly didn't).
