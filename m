Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbTF1Tsu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 15:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbTF1Tsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 15:48:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:48324 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265361AbTF1Tst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 15:48:49 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Asus CD-S520/A kernel I/O error
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <20030628195408.GA10099@deneb>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Sat, 28 Jun 2003 22:03:42 +0200
In-Reply-To: <20030628195408.GA10099@deneb> (Marco Ferra's message of "Sat,
 28 Jun 2003 20:54:08 +0100")
Message-ID: <87brwix941.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jun 2003, Marco Ferra wrote:

> It is _always_ at the end.  -raw96r doesn't seem to exist

Then you must have an old, or as Joerg would put it, ancient version.

> but reading the README.verify file the -pad argument option was
> mentioned.  Learning from the manpage it seems that this option can be
> used to correct this situation.

I don't think so. -pad is normally only for audio cds, IIRC. You could
also try -dao, which will work as long as your burners firmware isn't
b0rked, as it was with my acer 2010.

> I will get a blank cd tomorrow to try it.  Thanks a lot.  Tell me just
> more one thing using the data contained in the cd's recorded this way
> is bad?  Or can it be used normally? (I always used them and seemed
> OK).

The data is all good. And as lond as you don't use readcd or dd or
something similiar you won't realize the bug.

regards
Markus

