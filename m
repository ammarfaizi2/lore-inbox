Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbUKXOrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbUKXOrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbUKXOpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:45:30 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:57614 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262728AbUKXOmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:42:43 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: mpm@selenic.com, colin@colino.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
References: <20041118194959.3f1a3c8e.colin@colino.net>
	<87653wxqij.fsf@devron.myhome.or.jp> <20041124032017.GG8040@waste.org>
	<87pt237se1.fsf@devron.myhome.or.jp> <20041124053552.GD2460@waste.org>
	<871xejvk3l.fsf@devron.myhome.or.jp>
	<20041123224002.54a0e1e6.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 24 Nov 2004 22:26:26 +0900
In-Reply-To: <20041123224002.54a0e1e6.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 23 Nov 2004 22:40:02 -0800")
Message-ID: <87wtwbwf7h.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>>
>> AFAIK, EXT2 doesn't update all metadata synchronously in sync-mode.
>
> It does.

Umm... I was thinking that ext2 is using the delayed-write if it can
keep the consistency of metadata on-disk.

> I'm actually surprised to discover that [v]fat doesn't support `-o sync'. 
> It's probably a quite practical way of handling these various hotpluggable
> gadgets and would be a popular addition.

OK. If peoples really want this, I don't have objections.  I'll check
the patch.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
