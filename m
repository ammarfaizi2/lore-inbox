Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTKOBGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 20:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTKOBGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 20:06:13 -0500
Received: from pop.gmx.net ([213.165.64.20]:58540 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262714AbTKOBGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 20:06:10 -0500
X-Authenticated: #15936885
Message-ID: <3FB57C00.4080205@gmx.net>
Date: Sat, 15 Nov 2003 02:06:08 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.bkbits.net off the air
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry,

regarding rsync from bkbits.net to kernel.org, would it be possible to do
that with a post-incoming trigger in kernel.bkbits.net which starts rsync
to kernel.org? That should solve all atomicity requirements, at least on
the way from bkbits.net to kernel.org.
Same way for the CVS tree. Since you are starting the conversion (I assume
it's at least half automated), you could also add a call to rsync at the
end of that script.
Using rsync over ssh with pubkey authentication should be pretty
straightforward and also mostly secure, since no incoming connections to
bkbits.net are needed. The only thing listening to network connections
would be bkd.

Comments on the (in)feasibility of my suggestion are welcome.


Carl-Daniel
(happy bk user)

