Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264854AbTIJGMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 02:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264859AbTIJGMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 02:12:15 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:40696 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264854AbTIJGMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 02:12:13 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: atapi write support? No
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <3F5E2BA4.60704@wmich.edu> <20030909195428.GQ4755@suse.de>
	<3F5E338F.2000007@wmich.edu> <87brttemlk.fsf@gitteundmarkus.de>
	<3F5E4E6E.1070806@wmich.edu>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Wed, 10 Sep 2003 08:11:55 +0200
In-Reply-To: <3F5E4E6E.1070806@wmich.edu> (Ed Sweetman's message of "Tue, 09
 Sep 2003 18:04:30 -0400")
Message-ID: <87wuchgok4.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Sep 2003, Ed Sweetman wrote:

>Markus Plail wrote: 
>> On Tue, 09 Sep 2003, Ed Sweetman wrote:
>>>There is no other information needed.
>> There is...
> 
> You seemed to get it without any more.

Nope. Without the dev=ATAPI command line I wouldn't have had a clue
what could be wrong.

>> ATAPI: is most likely wrong for what you want to do. It's meant for
>> notebooks (PCATA or something).  If you just want to get rid of
>> ide-scsi, you have to use dev=/dev/hdX in cdrecord.
> 
> this method states that the method of access is unsupported and
> unintentional.  Which is why i didn't think that it was the right way
> to use cdrecord on atapi devices without ide-scsi.

The message is in because Jörg Schilling doesn't like the current
implementation at all. So he says one shouldn't use it, in order to
'force' kernel developers in another direction, e.g. Jeff Garzik's
libata.

>> PS: A little change in attitude towards people who are willing to
>> help you wouldn't be the worst idea. IMHO of course.
> 
> If you make what is a general question too specific with details you
> limit your responses if anyone thinks their response is correct for
> you anyway.  I limited my question as much as i wanted to, with the
> desired effect no less.

It had the effect that one had to ask you for more information before
one could give you an answer.

> apparently cdrecord's documention is a little behind it's code.

I don't think it is. If you don't find documentation for dev=/dev/hdX
then that's probably because Jörg doesn't want it to be used. I have
not checked myself though.

regars
Markus

