Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbUBWURZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbUBWURZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:17:25 -0500
Received: from mail.shareable.org ([81.29.64.88]:35970 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262032AbUBWUQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:16:46 -0500
Date: Mon, 23 Feb 2004 20:16:31 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Paul Jackson <pj@sgi.com>
Cc: hjlipp@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040223201631.GA32584@mail.shareable.org>
References: <20040216133418.GA4399@hobbes> <20040222020911.2c8ea5c6.pj@sgi.com> <20040222155410.GA3051@hobbes> <20040222125312.11749dfd.pj@sgi.com> <20040222225750.GA27402@mail.shareable.org> <20040222214457.6f8d2224.pj@sgi.com> <20040223142215.GB30321@mail.shareable.org> <20040223121205.2ef329fd.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223121205.2ef329fd.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> > Anyway that's irrelevant: the splitting change only affects shell _scripts_
> 
> The splitting does not affect only the scripts.  It also affects the
> argv[] array presented to the shells, which may or may not deal with
> such as we would like.

You misread what I wrote.  This is a rephrasing of what I wrote:

The splitting does not affect any shells when called by scripts with
<= 1 argument - because the splitting change doesn't affect anything
in those cases.

Therefore the shell behaviour is not relevant, except for such scripts.
On my system there are no such scripts.

-- Jamie
