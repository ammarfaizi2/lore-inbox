Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266000AbUBCNbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 08:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUBCNbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 08:31:10 -0500
Received: from main.gmane.org ([80.91.224.249]:41124 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266000AbUBCNbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 08:31:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Date: Tue, 03 Feb 2004 14:31:04 +0100
Message-ID: <yw1xad40i92f.fsf@kth.se>
References: <20040203131837.GF3967@aurora.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:87suTKZteOn83MWiBlSmzzGfRlA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Povolný <xpovolny@aurora.fi.muni.cz> writes:

> I have debian's 2.6.0-686-smp only with PNP BIOS disabled (fails to
> boot with enabled, as described by other people).
>
> I did
>
> $ mount /cdrom/
> $ ls /cdrom/
>
> got listing of files and directories on the cdrom
> then
>
> $ cdrecord dev=/dev/hdc -blank=fast -v

It's not very nice to go and erase the CD while it's mounted.  Unmount
first and you'll be fine.

-- 
Måns Rullgård
mru@kth.se

