Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUIVAih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUIVAih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 20:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUIVAih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 20:38:37 -0400
Received: from open.hands.com ([195.224.53.39]:59021 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S267452AbUIVAif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 20:38:35 -0400
Date: Wed, 22 Sep 2004 01:49:42 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: FUSE fusexmp proxy example solves umount problem!
Message-ID: <20040922004941.GC14303@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what do people think about a filesystem proxy kernel module?
has anyone heard of such a beast already?
(which can also do xattrs)

fusexmp.c (in file system in userspace package) does stateless
filesystem proxy redirection.

this is a PERFECT solution to the problem of users removing media
from drives without warning.  when i say perfect i mean it doesn't
cause kernel hang-ups, it doesn't involve modifications to userspace
programs such as KDE or Gnome, it doesn't involve any extra work
to HAL, nor UDEV.

it just... _works_.

but, doing file system proxying in userspace introduces an additional
and unnecessary level of inefficiency.

i was wondering therefore if anyone had attempted to do filesystem
proxying before.

ta,

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

