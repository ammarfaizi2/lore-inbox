Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWIHNrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWIHNrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 09:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWIHNrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 09:47:52 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:35484 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751108AbWIHNrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 09:47:51 -0400
Date: Fri, 8 Sep 2006 15:47:03 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Oleg Verych <olecom@flower.upol.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: re-reading the partition table on a "busy" drive
In-Reply-To: <4501714F.9030709@tls.msk.ru>
Message-ID: <Pine.LNX.4.61.0609081546260.25316@yvahk01.tjqt.qr>
References: <45004707.4030703@tls.msk.ru> <450105C0.2010603@flower.upol.cz>
 <Pine.LNX.4.61.0609080857090.30219@yvahk01.tjqt.qr> <20060908135858.GB14370@flower.upol.cz>
 <4501714F.9030709@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> My anwser to this question: if it's so "pretty annoying", just let it be
>> "yes, do as i said !", not more and not less, just most ;).
>
>Well, this whole question is already moot, as pointed out by Olaf.
>Because kernel already supports add/delete single partition ioctls,
>which is sufficient.  For my needs I already wrote a tiny hack which
>compares /proc/partitions with the output of `sfdisk -d' and re-adds
>anything which changed.  It should be possible to do the same with
>parted instead of {sf,cf,f}disk without using that hack, but hell,
>all those fdisks (parted included) sucks badly, each in its own way,
>so all are being used for different parts of the task, including the
>hack ;)

So something should write the perfect utility. There are people on this 
list capable of this, like we have seen with git :)


Jan Engelhardt
-- 
