Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTJ2Us5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 15:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTJ2Us5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 15:48:57 -0500
Received: from main.gmane.org ([80.91.224.249]:3526 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261667AbTJ2Usz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 15:48:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Possible to recover this Raid 5 Array?
Date: Wed, 29 Oct 2003 21:48:53 +0100
Message-ID: <yw1xptgf93d6.fsf@kth.se>
References: <20031029193646.GA18778@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:S5AEVx/v04/DO5yAB8g3N4yX5Mc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

> Now I have the two good drives put together in a degraded array, and luckily
> I'm able to mount the beast, and am able to read a surprising amount of data
> (it takes a long time to fully fsck 300GB, so it wasn't able to get to the
> entire filesystem with the old disk in the array before I canceled it)
>
> The array was about 10% full when this happened.
>
> I'm checking what I can recover, but my home directory was on there, and I
> only had partial backups.  I have restored what was in the backups, but a
> lot of files I hoped were backed up weren't.
>
> Is there some miracle that can be performed on with this?

I don't think so.  In cases like this, the first thing to do is to
make a copy of the damaged filesystem, and work on the copy.  If
you're lucky, a tool like e2retrieve might be able to salvage some
more data than fsck (http://coredump.free.fr/linux/e2retrieve.php).

-- 
Måns Rullgård
mru@kth.se

