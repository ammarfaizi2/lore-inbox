Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276279AbRI1Tyk>; Fri, 28 Sep 2001 15:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276278AbRI1Tya>; Fri, 28 Sep 2001 15:54:30 -0400
Received: from zeke.inet.com ([199.171.211.198]:38351 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S276280AbRI1TyT>;
	Fri, 28 Sep 2001 15:54:19 -0400
Message-ID: <3BB4D57A.C8E06654@inet.com>
Date: Fri, 28 Sep 2001 14:54:34 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: n0ano@indstorage.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] core file naming option
In-Reply-To: <E15mHSd-0000mh-00@the-village.bc.nu> <3BB20F26.5575897B@inet.com> <20010928123453.A892@tlaloc.indstorage.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

n0ano@indstorage.com wrote:
> Having the 2.2.x series create `core.pid' is like a 2 line change
> to `fs/binfmt_elf.c', just increase the size of the array that holds
> the file name and `sprintf' the pid into it.  I've got a patch for
> the 2.2.x series that dumps core for all threads and puts them in
> `core.pid' files.

Well, when I asked Alan about it, he said "Doing it in 2.2 is incredibly
hard for internal locking reasons"... I'm not ready to tackle that.
If you have a patch that does it correctly, submit it to Alan.
I'd still like to have the option I submitted as part of 2.2 *shrug*...
it's just bringing back functionality that was in earlier versions of
Linux as a compile option.  (From what I understand, this is similar to
something done in the BSDs at some time in the past... but being a young
whippersnapper, I don't really know.)

Eli
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
