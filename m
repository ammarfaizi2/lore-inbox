Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbUCXGtu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 01:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbUCXGtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 01:49:49 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:20988 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263037AbUCXGts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 01:49:48 -0500
To: David Eger <eger@havoc.gtf.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] UTF-8ifying the kernel sources
References: <20040323230209.GA25510@havoc.gtf.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 24 Mar 2004 15:49:34 +0900
In-Reply-To: <20040323230209.GA25510@havoc.gtf.org>
Message-ID: <buozna6d9j5.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Eger <eger@havoc.gtf.org> writes:
> Two files containing Japanese comments - in two different charsets!
> Unfortunately, emacs doesn't understand CJK pages in UTF-8.  

If you're using a recent version of GNU Emacs (I'm not sure how recent
-- I track emacs CVS), do:

   M-x utf-translate-cjk-mode RET

That will make emacs handle CJK UTF-8 properly (it's not turned on by
default because it involves loading some large tables).

-Miles
-- 
"1971 pickup truck; will trade for guns"
