Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbTLFAo5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbTLFAo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:44:57 -0500
Received: from main.gmane.org ([80.91.224.249]:11207 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264891AbTLFAo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:44:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Large-FAT32-Filesystem Bug
Date: Sat, 06 Dec 2003 01:44:53 +0100
Message-ID: <yw1x1xri3hbu.fsf@kth.se>
References: <3FD0555F.5060608@gmx.de> <20031205160746.GA18568@codepoet.org>
 <3FD0C64D.5050804@gmx.de> <20031205221051.GA3244@codepoet.org>
 <20031205224529.GS29119@mis-mike-wstn.matchmail.com>
 <yw1x65gu3kyp.fsf@kth.se> <jewu9add70.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:wZF7lPtB9/76uJu0LXEhrRYy5L0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

>>>> No problem.  I put this patch together quite a while ago for
>>>> my own use and never got around to sending it in.  It removes
>>>> a number of artificial fat32 limits, and allows files up to 4GB,
>>>
>>> Why only 4gb?
>>
>> That's what the 32 in fat32 means.
>
> No, it doesn't.  It's about the number of bits in a cluster number, thus
> the size of the filesystem.  And that 32 is actually 28.

OK, my mistake, but there is a 32 as in file size, right?

-- 
Måns Rullgård
mru@kth.se

