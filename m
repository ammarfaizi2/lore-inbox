Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWC2PMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWC2PMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 10:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWC2PMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 10:12:19 -0500
Received: from mail.parknet.jp ([210.171.160.80]:55045 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1750804AbWC2PMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 10:12:18 -0500
X-AuthUser: hirofumi@parknet.jp
To: "Paul Rolland" <rol@witbe.net>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fat: kill reserved names
References: <000701c65340$d9736ab0$b600a8c0@cortex>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 30 Mar 2006 00:12:10 +0900
In-Reply-To: <000701c65340$d9736ab0$b600a8c0@cortex> (Paul Rolland's message of "Wed, 29 Mar 2006 16:55:41 +0200")
Message-ID: <87hd5hqo8l.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul Rolland" <rol@witbe.net> writes:

> Microsoft Windows XP [Version 5.1.2600]
> (C) Copyright 1985-2001 Microsoft Corp.
>
> D:\>mkdir LPT1
> The directory name is invalid.
>
> Windows doesn't want these !!!

I was thinking so too, however, it can actually do.
On Windows, you should

	echo > \\?\d:\LPT1

See http://marc.theaimsgroup.com/?t=114289107300003&r=1&w=2
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
