Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWARVov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWARVov (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWARVov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:44:51 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:60128 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S964953AbWARVou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:44:50 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
To: Roman Zippel <zippel@linux-m68k.org>, Ben Collins <ben.collins@ubuntu.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 18 Jan 2006 22:51:11 +0100
References: <5roZI-5y9-29@gated-at.bofh.it> <5sSVt-5Du-1@gated-at.bofh.it> <5sWwg-2Bq-21@gated-at.bofh.it> <5t4kf-5Px-11@gated-at.bofh.it> <5t5zv-7GD-31@gated-at.bofh.it> <5tXA1-3Lh-35@gated-at.bofh.it> <5u04G-7s6-19@gated-at.bofh.it> <5u8Yt-317-41@gated-at.bofh.it> <5u9L8-4gd-19@gated-at.bofh.it> <5uadH-4TM-1@gated-at.bofh.it> <5uaQp-5UL-7@gated-at.bofh.it> <5ubjI-6KH-21@gated-at.bofh.it> <5ubtB-6Xy-9@gated-at.bofh.it> <5uBdT-2Gn-23@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EzLCy-0001uG-7x@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
> On Thu, 12 Jan 2006, Ben Collins wrote:

>> What I don't understand is that if oldconfig is an interactive target,
>> why make it work when interactivity is not available?
> 
> It means it will accept any input and no input (by just pressing enter or
> ctrl-d) means the default answer.

If I press ^D, I'd expect to select the abort option (like e.g. all sane
GUIs do if you close yes/no/abort dialogs instead of selecting a button).
I can see no advantage from implementing this unexpected behaviour.

<rant>
I don't understand programmers trying to go ahead even if they know they're
going the wrong way. The header file can't be found - let's see if it wasn't
needed, maybe the programmer inserted it just for fun! There is an unknown
argument '--version'? Just ignore it and start the operation, it won't have
been that important! *grrrrrr*
</rant>
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
