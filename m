Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVC3NM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVC3NM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 08:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVC3NM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 08:12:27 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:36111 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261856AbVC3NMX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 08:12:23 -0500
To: =?iso-8859-1?q?Xu=E2n_Baldauf?= 
	<xuan--2004.03.29--linux-kernel--vger.kernel.org@baldauf.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vfat: why is shortname=lower the default?
References: <4249BB5C.5000102@baldauf.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 30 Mar 2005 22:12:01 +0900
In-Reply-To: <4249BB5C.5000102@baldauf.org> (
 =?iso-8859-1?q?Xu=E2n_Baldauf's_message_of?= "Tue, 29 Mar 2005 22:32:28
 +0200")
Message-ID: <871x9xs2fy.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xuân Baldauf <xuan--2004.03.29--linux-kernel--vger.kernel.org@baldauf.org> writes:

> Why is shortname=lower the default mount option for vfat filesystems?
> Because, with "shortname=lower", copying one FAT32 filesystem tree to
> another FAT32 filesystem tree using Liux results in semantically
> different filesystems. (E.g.: Filenames which were once "all
> uppercase" are now "all lowercase").

The reason is only it's very long-standing behavior.  When this
behavior was changed before, it seems an one user was confused at
least.

    http://marc.theaimsgroup.com/?t=97041869500002&r=1&w=2

Personally I agree that "winnt" or "mixed" is proper.

However, if we want to change the default behavior, it would need to
be tested for some months, and if anyone has no objection it can
change I think.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
