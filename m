Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293643AbSCER6W>; Tue, 5 Mar 2002 12:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293647AbSCER6M>; Tue, 5 Mar 2002 12:58:12 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:41989 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S293643AbSCER57>; Tue, 5 Mar 2002 12:57:59 -0500
To: "Rajan Ravindran" <rajancr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
In-Reply-To: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 06 Mar 2002 02:57:36 +0900
In-Reply-To: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com>
Message-ID: <873czeaodr.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rajan Ravindran" <rajancr@us.ibm.com> writes:

> Yes, pid's are guaranteed to be unique.
> Here the problem we focused is the time taken in finding the next
> available free pid.
> I really don't mean by your task->xxx.

I'm confused.

I said:
	task { pid = 300, pgrp = 301, };
	301 is free;

	get_pid() returns 301.

"task 301" can't call setsid(). pid 301 is available?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
