Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbTGCRv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 13:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbTGCRv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 13:51:27 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:54527 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S265188AbTGCRvX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 13:51:23 -0400
Subject: Re: [PATCH] Add SELinux module to 2.5.74-bk1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       James Morris <jmorris@intercode.com.au>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030703175153.GC27556@gtf.org>
References: <1057254295.1110.1016.camel@moss-huskers.epoch.ncsc.mil>
	 <20030703175153.GC27556@gtf.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1057255509.1110.1030.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jul 2003 14:05:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-03 at 13:51, Jeff Garzik wrote:
> nitpicks:
> 
> 1) "selinux" is a poor toplevel directory.  We already have the toplevel
> "security" directory, this code should go in there.

Sorry, I bungled the diffstat (forgot -p1), as pointed out by Greg and
Chris.

> 2) stick includes in the standard include/ directory.  I would suggest
> include/security (if the headers are general) or
> include/security/selinux.

Even if the headers are private to the SELinux "module"?  No other
kernel code uses them.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

