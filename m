Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUFWVvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUFWVvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUFWVuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:50:11 -0400
Received: from havoc.gtf.org ([216.162.42.101]:24006 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261500AbUFWVqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:46:54 -0400
Date: Wed, 23 Jun 2004 17:46:53 -0400
From: David Eger <eger@havoc.gtf.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alphabet of kernel source
Message-ID: <20040623214653.GA29728@havoc.gtf.org>
References: <20040623140628.3f1abfe9@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623140628.3f1abfe9@lembas.zaitcev.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I started a thread a while ago (2.6.3/2.6.4) where I submitted some
patches to UTF-8ifying the kernel sources.  Basically, most of the
kernel is ASCII (98.4% of the files).  The rest are mostly ISO-Latin-1,
with the rare bit of Japanese (in a couple of charsets) and some just
random bytes in some of the Documentation/...

http://www.yak.net/random/linux-2.6.4-utf8-cleanup-auto.diff
http://www.yak.net/random/linux-2.6.4-utf8-cleanup-cstrings2utf8.diff
http://www.yak.net/random/linux-2.6.4-utf8-cleanup-jp.diff
http://www.yak.net/random/linux-2.6.4-utf8-cleanup-wrong.diff

It's sorta difficult to do non-ASCII patches over email because
the kernel developers like reading their mail in mutt, and don't 
like attachments (the only sane ways to send non 7-bit clean data:
8-bit MIME: tagged and bagged or uuencoded)

Further, you confuse the hell out of vi if you have any trash (8bit data
in another charset) in a file that's supposed to be UTF-8.  i.e. don't
think you're going to be able to look at a charset changing patch in
anything.

-dte

