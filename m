Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVJCPy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVJCPy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVJCPy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:54:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26291 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932322AbVJCPy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:54:57 -0400
Date: Mon, 3 Oct 2005 08:54:14 -0700
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, jgarzik@pobox.com, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com, coywolf@gmail.com,
       greg@kroah.com
Subject: Re: [PATCH] Document patch subject line better
Message-Id: <20051003085414.05468a2b.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0510030805380.31407@g5.osdl.org>
References: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com>
	<Pine.LNX.4.64.0510030805380.31407@g5.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus:
> Hint: missing "---".

True.

I did put it in, but "quilt refresh" took it out.

I send patches directly from my quilt patches directory.  The patches
file ends up being -exactly- the email message body.  I did put in a
"---", with a short comment about how this patch fit in with the
earlier ones of yesterday, and removed the "Index: " and "========="
lines that quilt adds.

But then I forgot and ran a "quilt refresh" before I sent the patch,
and it erased that "---" line and comments, and reestablished its
"Index: " and "=========" lines, as it always does.

Ideally either I should change my patch sending process, or I should
change quilt.  I don't know which yet.  Meanwhile, I am taking
advantage of the hack in your tools that filters out "Index: " lines.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
