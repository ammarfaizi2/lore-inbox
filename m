Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267814AbUHPR1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267814AbUHPR1O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUHPR1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:27:14 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:41211 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S267814AbUHPR1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:27:10 -0400
Subject: Re: [PATCH] use simple_read_from_buffer in selinuxfs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040814161521.C1924@build.pdx.osdl.net>
References: <20040814161521.C1924@build.pdx.osdl.net>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1092677137.16631.156.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 13:25:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-14 at 19:15, Chris Wright wrote:
> Use simple_read_from_buffer.  This also eliminates page allocation
> for the sprintf buffer.  Switch to get_zeroed_page instead of
> open-coding it.  Viro had ack'd this earlier.  Still applies w/
> the transaction update.
> 
> Signed-off-by: Chris Wright <chrisw@osdl.org>

Thanks, looks fine to me.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

