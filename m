Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbUDTBUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUDTBUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 21:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDTBUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 21:20:50 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:7181 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262073AbUDTBUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 21:20:49 -0400
Date: Tue, 20 Apr 2004 09:27:04 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Venkata Ravella <Venkata.Ravella@synopsys.com>,
       linux-kernel@vger.kernel.org, Ramki.Balasubramanium@synopsys.com,
       ab@californiadigital.com, autofs@linux.kernel.org
Subject: Re: Automount/NFS issues causing executables to appear corrupted
In-Reply-To: <40846DB7.4090102@zytor.com>
Message-ID: <Pine.LNX.4.58.0404200916221.12229@wombat.indigo.net.au>
References: <200404200008.i3K08Zvs018948@radium.internal.synopsys.com>
 <40846DB7.4090102@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004, H. Peter Anvin wrote:

> Venkata Ravella wrote:
> > autofs version is autofs-3.1.7-21
> > 
> > I also have one new update. We started seeing similar problem on
> > the system running the kernel 2.4.18-e.12smp which has the same
> > version(3.1.7-21) of autofs as well.
> > 
> > This may or may not be an autofs problem but, restarting autofs
> > fixes this problem temporarily.
> > 
> 
> That will cause an NFS remount.  This really feels much more like an NFS
> problem.

Certainly does.

Venkata,

Can you also forward this question to the nfs list at 
nfs@lists.sourceforge.net. Sorry to ask you to post all over the place.

Please investigate the NFS client patches maintained by Trond Myklebust. 
Check nfs.sourceforge.net. We found we had to use them in early 2.4 versions.

Ian


