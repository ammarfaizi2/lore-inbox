Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbUJZHkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbUJZHkG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 03:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbUJZHjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 03:39:22 -0400
Received: from almesberger.net ([63.105.73.238]:24592 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262168AbUJZHiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 03:38:15 -0400
Date: Tue, 26 Oct 2004 04:38:06 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make buffer head argument of buffer_##name "const"
Message-ID: <20041026043806.A6073@almesberger.net>
References: <20041026033241.B7983@almesberger.net> <20041026002342.5fb15ab3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026002342.5fb15ab3.akpm@osdl.org>; from akpm@osdl.org on Tue, Oct 26, 2004 at 12:23:42AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> OK, but why?  Does it generate better code or something?

I wouldn't expect this to change the resulting code. It's just
so that one can feed it a "const" pointer, which allows other
functions to use "const", etc.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
