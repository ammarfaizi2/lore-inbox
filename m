Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbTHVOsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 10:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTHVOsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 10:48:17 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:5134 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263314AbTHVOsP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 10:48:15 -0400
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Call security hook from pid*_revalidate
References: <20030819013834.1fa487dc.akpm@osdl.org>
	<1061327958.28439.62.camel@moss-spartans.epoch.ncsc.mil>
	<20030819142234.64433bad.akpm@osdl.org>
	<87wud8pecx.fsf@devron.myhome.or.jp>
	<1061498191.25855.77.camel@moss-spartans.epoch.ncsc.mil>
	<1061501984.25855.110.camel@moss-spartans.epoch.ncsc.mil>
	<1061504298.25855.125.camel@moss-spartans.epoch.ncsc.mil>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 22 Aug 2003 23:47:27 +0900
In-Reply-To: <1061504298.25855.125.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <874r09oikg.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@epoch.ncsc.mil> writes:

> Third version of the same patch against 2.6.0-test3-mm3, this time using
> proc_type rather than directly extracting the type from the inode
> number.

I think it fixed security problem of original patch. Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
