Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264636AbSJ3JcH>; Wed, 30 Oct 2002 04:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264642AbSJ3JcG>; Wed, 30 Oct 2002 04:32:06 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:14283 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264636AbSJ3JcD>; Wed, 30 Oct 2002 04:32:03 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: andersen@codepoet.org, Dave Cinege <dcinege@psychosis.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
References: <200210272017.56147.landley@trommello.org>
	<200210300229.44865.dcinege@psychosis.com>
	<3DBF8CD5.1030306@pobox.com>
	<200210300322.17933.dcinege@psychosis.com>
	<20021030085149.GA7919@codepoet.org>
	<buofzuogv31.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3DBFA0F8.9000408@pobox.com>
	<buobs5cgu7o.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3DBFA5C7.1080603@pobox.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 30 Oct 2002 18:38:24 +0900
In-Reply-To: <3DBFA5C7.1080603@pobox.com>
Message-ID: <buo7kg0gtbj.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:
> I'm not saying that initramfs will do 
> this out of the box :) but going from initramfs to "initromfs" should 
> not be a huge leap...

Do you mean by putting the `internal' format that initramfs normally
uses in RAM, in ROM, and skip the initial decompression step?

Or do you mean have it somehow avoid copying the data areas of the cpio
stream (i.e. store pointers from the tree-in-ram to the actual data
blocks in ROM).

I guess the latter sounds cleaner... it would also have the advantage
that you could have a tree with the bulk of data in ROM, but which
allowed new files to be written (which would be stored in RAM).

Hmmm...sounds very intersting...

-Miles
-- 
I'd rather be consing.
