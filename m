Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbVAQSXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbVAQSXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbVAQSTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:19:47 -0500
Received: from thunk.org ([69.25.196.29]:22705 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262832AbVAQSRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:17:00 -0500
Date: Mon, 17 Jan 2005 13:16:52 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Richard Moser <nigelenki@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux Kernel Audit Project?
Message-ID: <20050117181652.GB25974@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	John Richard Moser <nigelenki@comcast.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41EB6691.10905@comcast.net> <41EB6BD6.5070702@comcast.net> <1105962233.12709.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105962233.12709.68.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 12:23:35PM +0000, Alan Cox wrote:
> 
> - Tools like coverity and sparse are significantly increasing the number
> of flaws found. In particular they are turning up long time flaws in
> code, but they also mean new flaws of that type are being found. People
> aren't really turning these tools onto user space - yet -
> 

Also, most of the kernel vulernabilities that have been found are not
remote execution vulernabilities, but privilege escalation bugs, or
data leakage bugs (technically a security vulnerability but most of
the time what gets leaked is truly boring) or denial of service bugs
(yawn; there are enough ways of carrying out DOS attacks that don't
represent kernel bugs).  The percentage of vulnerabilities which are
actually of the "browse a certain web page with Internet Exploder and
you are 0wned" are far fewer with kernel bugs, by their very nature.
That's not to say that such bugs shouldn't be fixed, but that unless
you're some hack from the Yankee Group getting paid by Microsoft,
there's no point to ring the alarm bells.

Finally, it's important to take statistical analysis with a huge grain
of salt sometimes; but an increase it bugs found doesn't mean that the
product is getting buggier; just that more bugs are happenning to get
fixed.  You need to do a lot more analysis to discover if this is due
to code analysis tools finding bugs in old code, or bugs being turned
up in newly modified code, etc.

							- Ted
