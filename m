Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030833AbWJDShz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030833AbWJDShz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030828AbWJDShy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:37:54 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:1192 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1030779AbWJDShy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:37:54 -0400
Date: Wed, 4 Oct 2006 12:37:53 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Must check what?
Message-ID: <20061004183752.GG28596@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd like to propose that anyone adding __must_check markers in the
future be forced to *WRITE SOME FUCKING DOCUMENTATION* about exactly
what it is the caller is supposed to be checking.

extern int __must_check bus_register(struct bus_type * bus);

Why, thank you.  Does it return 0 for success, or 1 on success?  Does it
return an errno?

