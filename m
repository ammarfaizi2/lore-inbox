Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbTJGOHd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbTJGOHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:07:33 -0400
Received: from main.gmane.org ([80.91.224.249]:60130 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262404AbTJGOHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:07:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: devfs vs. udev
Date: Tue, 07 Oct 2003 16:07:25 +0200
Message-ID: <yw1xekxpdtuq.fsf@users.sourceforge.net>
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <pan.2003.10.07.13.41.23.48967@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:tAHuGh47hgNT6dTgk9MMmAtB3S8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus <aj@dungeon.inka.de> writes:

>> I noticed this in the help text for devfs in 2.6.0-test6:
>> 
>> 	  Note that devfs has been obsoleted by udev,
>
> devfs works fine, lists all devices, and obsoletes makedev.

That's my experience.

> udev needs patching for several issues, current sysfs only exports
> many but by far not all devices, and because of that makedev
> is still needed to create an initial /dev.
>
> in short: devfs works fine. udev has quite a way to go.
> so marking devfs obsolete was done too soon by far. but

Exactly my point.

I'd also like an explanation of the rationale behind the switch.
devfs works and is stable.  Why replace it with an incomplete fragile
userspace solution?  I recall reading something about the original
author not updating devfs recently, but I can't see why that requires
rewriting it from scratch.

-- 
Måns Rullgård
mru@users.sf.net

