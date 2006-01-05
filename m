Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWAEAww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWAEAww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWAEAvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:51:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751009AbWAEAvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:51:01 -0500
Date: Wed, 4 Jan 2006 16:50:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
cc: Andrew Morton <akpm@osdl.org>, Joel Becker <Joel.Becker@oracle.com>,
       Arjan van de Ven <arjan@infradead.org>, Christoph Hellwig <hch@lst.de>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: merging ocfs2?
In-Reply-To: <43BAF93A.10509@oracle.com>
Message-ID: <Pine.LNX.4.64.0601041649270.3668@g5.osdl.org>
References: <43BAF93A.10509@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Jan 2006, Zach Brown wrote:
>
> Joel has done the heavy lifting to bring its git repository up to date
> so one should be able to pull from:
> 
>   http://oss.oracle.com/git/ocfs2.git

If Christoph is happy with it, and there has been no grumbling from -mm, I 
can certainly merge it.

However, I really _really_ prefer that people who use git to merge use the 
native git protocol, which I trust. That http: thing may work, but it's a 
cludge ;)

Can you run git-daemon on the machine? 

		Linus
