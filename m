Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTKNQga (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 11:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbTKNQga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 11:36:30 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:48012 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262772AbTKNQg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 11:36:29 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Nov 2003 08:35:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Larry McVoy <lm@bitmover.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <20031114150047.GC30711@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0311140830290.1827-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Nov 2003, Larry McVoy wrote:

> One of us is not getting it, maybe it's me.  To build something like
> you describe is pretty easy IF AND ONLY IF all you are asking for is an
> update mechanism.  As soon as you want revision history, diffs, rollbacks,
> modifiable files, etc., you have to go to real BK.  Is that OK?  All you

Spec for bk-lite:

1) Binary with "no worky on other SCM" kinda license
2) update+history+diff (no rollbacks, no modifiable files, no etc...)

In that way all current users of bk2cvs, bk2svn, bk2xxx can simply do a 
pull from a bk repo and have they own scripts on their local machine to do 
their bk2xxx. It will be a lower headache for you and for kernel.org 
maintainers. Is it feasible ?



- Davide


