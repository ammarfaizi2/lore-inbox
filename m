Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbVJCUkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVJCUkP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 16:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVJCUkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 16:40:15 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:64268 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932426AbVJCUkO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 16:40:14 -0400
Date: Mon, 3 Oct 2005 22:40:10 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Paul Jackson <pj@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, Randy Dunlap <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Document patch subject line better
Message-Id: <20051003224010.4920b10e.khali@linux-fr.org>
In-Reply-To: <20051003085414.05468a2b.pj@sgi.com>
References: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com>
	<Pine.LNX.4.64.0510030805380.31407@g5.osdl.org>
	<20051003085414.05468a2b.pj@sgi.com>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> I send patches directly from my quilt patches directory.  The patches
> file ends up being -exactly- the email message body.  I did put in a
> "---", with a short comment about how this patch fit in with the
> earlier ones of yesterday, and removed the "Index: " and "========="
> lines that quilt adds.

FYI, quilt 0.41 and above have a --no-index option to the refresh
command, which will avoid this second annoyance. You can simply add the
following to ~/.quiltrc:

QUILT_NO_DIFF_INDEX=1

And the default behavior will be changed to match Linus' requirements.

-- 
Jean Delvare
