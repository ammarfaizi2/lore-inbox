Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266972AbTADQSj>; Sat, 4 Jan 2003 11:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266974AbTADQSj>; Sat, 4 Jan 2003 11:18:39 -0500
Received: from skunk.physik.uni-erlangen.de ([131.188.163.240]:37573 "EHLO
	skunk.physik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S266972AbTADQSi>; Sat, 4 Jan 2003 11:18:38 -0500
From: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>
Date: Sat, 4 Jan 2003 17:27:11 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: writing from kernel
Message-ID: <20030104172711.A20363@skunk.physik.uni-erlangen.de>
References: <20030104160255.6187.qmail@webmail28.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20030104160255.6187.qmail@webmail28.rediffmail.com>; from linux_ker@rediffmail.com on Sat, Jan 04, 2003 at 04:02:55PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jan 04, 2003 at 04:02:55PM -0000, anil  vijarnia wrote:
> can anyone tell me how to write into i file from kernel space.
> i tried sys_open,sys_write functions bbbbbut they don't work
>  from my module.

As far as I understand the general oppinion on this list :-) the
preferred method is to have your module preset a character-device
to userspace. Then use a small program to do the I/O.

This normally keeps your kernel module simple and allows for
arbitrary compex I/O in userspace.

        Chris

-- 
No keyboard present
Hit F1 to continue
Zen engineering?
-- Jim Griffith
