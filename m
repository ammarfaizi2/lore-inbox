Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUBIAif (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 19:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbUBIAif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 19:38:35 -0500
Received: from almesberger.net ([63.105.73.238]:59654 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264246AbUBIAie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 19:38:34 -0500
Date: Sun, 8 Feb 2004 21:38:28 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Michael Frank <mhf@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] defer panic for too many items in boot parameter line
Message-ID: <20040208213828.I1325@almesberger.net>
References: <200402090623.05965.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402090623.05965.mhf@linuxmail.org>; from mhf@linuxmail.org on Mon, Feb 09, 2004 at 06:23:04AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank wrote:
> Ah, nice, I like to defer a panic on zone init failure.
> 
> Perhaps we could combine the panic side and use panic_later.

Sure, why not ? In the long run, it would make sense to turn such
not-really-fatal panics into something less drastic (I'm actually
a bit surprised that these panics were added in the course of
2.5), but I guess that can wait.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
