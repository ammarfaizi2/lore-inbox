Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbUBWU3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUBWU1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:27:34 -0500
Received: from imap.gmx.net ([213.165.64.20]:20119 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262035AbUBWU1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:27:25 -0500
X-Authenticated: #20799612
Date: Mon, 23 Feb 2004 21:25:24 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Paul Jackson <pj@sgi.com>
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040223202524.GC13914@hobbes>
References: <20040216133418.GA4399@hobbes> <20040222020911.2c8ea5c6.pj@sgi.com> <20040222155410.GA3051@hobbes> <20040222125312.11749dfd.pj@sgi.com> <20040222225750.GA27402@mail.shareable.org> <20040222214457.6f8d2224.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222214457.6f8d2224.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 09:44:57PM -0800, Paul Jackson wrote:
> > I believe the question was "which shell expects the name in argv[2]
> 
> The question is more like: examine each shell's argument parsing code to
> determine which ones will or will not be affected by this.  For a change
> like this, someone needs to actually look at the code for each major
> shell, and verify their reading of the code with a little experimentation.

I still don't understand your argument... If there is a shell having
those problems, nobody would use something like

#!/shell -foo -bar

And the "old"

#!/shell -foo

or

#!/shell

still work as usual (if there are no whitespace characters in the
parameter).

Regards,

	Hansjoerg Lipp
