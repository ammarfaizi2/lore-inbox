Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbVHZPtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVHZPtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbVHZPtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:49:53 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:9963 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S965089AbVHZPtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:49:52 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: Initramfs and TMPFS!
To: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org,
       robotti@godmail.com
Reply-To: 7eggert@gmx.de
Date: Fri, 26 Aug 2005 17:49:36 +0200
References: <4Fuuy-6df-11@gated-at.bofh.it> <4FJMZ-1YX-17@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1E8gSX-0001S6-O9@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> wrote:
> On Thu, Aug 25, 2005 at 02:15:13PM -0400, robotti@godmail.com wrote:

>> For one, if you do "dd if=/dev/zero of=foo" on a ramfs the system
>> will lock up.
> 
> "Doctor, it hurts when I do this!" "Well, then don't do that."
> You found a nice case of "Unix, rope, foot".

It's a case of going into the mountains wearing sandals and carrying the
mountain boots in your backpack knowing you should wear them (at least if
you read the hidden documentation.

If you can leave the sandals at home, you should do that (they are of no use
there), but the patch from this(?) thread will just make you change shoes
after leaving the house and carry the sandals in the backpack, which could
easily be done in userspace (provided you've enough RAM). The real patch
would teach how to tie the bootstraps of tmpfs before leaving the house.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
