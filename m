Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTEYLwa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 07:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTEYLw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 07:52:29 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:49163 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262032AbTEYLw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 07:52:27 -0400
Date: Sun, 25 May 2003 13:05:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Cc: Ben Collins <bcollins@debian.org>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030525130533.A9127@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Ben Collins <bcollins@debian.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030525112150.3994df9b.l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030525112150.3994df9b.l.s.r@web.de>; from l.s.r@web.de on Sun, May 25, 2003 at 11:21:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 11:21:50AM +0200, René Scharfe wrote:
> This looks suspiciously like strlcpy() from the *BSDs. Why not name it
> so?
> 
> The following patch is based on Samba's implementation (found in
> source/lib/replace.c). I just reformatted it somewhat, there are no
> functional changes. What do you think?

Looks good, you probably need a prototype in include/linux/string.h and
a samba copyright boilerplate in lib/string.c.

What about strlcat?

