Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316053AbSEOMkt>; Wed, 15 May 2002 08:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316143AbSEOMks>; Wed, 15 May 2002 08:40:48 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:48655 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S316053AbSEOMkr>; Wed, 15 May 2002 08:40:47 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: msmith@operamail.com (Malcolm Smith), linux-kernel@vger.kernel.org,
        chaffee@cs.berkeley.edu
Subject: Re: [RFC] FAT extension filters
In-Reply-To: <200205150318.g4F3IPY103245@saturn.cs.uml.edu>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 15 May 2002 21:39:53 +0900
Message-ID: <87u1p960va.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> Also I found a bug in the vfat code. It doesn't
> properly handle old (pre-vfat) files with names
> that start with 0xE5; these are stored on disk
> with 0x05 as the first character.

Umm... why? 0xE5 is free entry mark.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
