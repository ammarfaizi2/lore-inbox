Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276906AbRJVPsB>; Mon, 22 Oct 2001 11:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276532AbRJVPrl>; Mon, 22 Oct 2001 11:47:41 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:19462 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S276906AbRJVPr3>; Mon, 22 Oct 2001 11:47:29 -0400
Date: Mon, 22 Oct 2001 11:47:52 -0400
Message-Id: <200110221547.f9MFlqK15823@deathstar.prodigy.com>
To: kaos@ocs.com.au
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
X-Newsgroups: linux.dev.kernel
In-Reply-To: <23837.1003738907@kao2.melbourne.sgi.com>
Organization: TMR Associates, Schenectady NY
Cc: linux-kernel@vger.kernel.org
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <23837.1003738907@kao2.melbourne.sgi.com> you write:

| When the post-install and pre-remove entries for module binfmt_misc are
| hard coded into modprobe, there is no syntax in modules.conf to prevent
| modprobe from always issuing those commands.  The next time somebody
| decides that binfmt_misc needs different commands, everybody using the
| old modutils on the new kernel will break.  I don't want the hassle,
| put it in modules.conf where it can easily be changed.

  Thank you. Configuration things should be in configuration files!

  I hope people will continue to resist changes which make things easy
for casual users while making them very difficult for more technically
inclined people. Having to get source and recompile to disable a feature
is hardly reasonable.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
