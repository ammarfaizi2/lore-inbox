Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262932AbTC3BI1>; Sat, 29 Mar 2003 20:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262942AbTC3BI1>; Sat, 29 Mar 2003 20:08:27 -0500
Received: from A17-250-248-87.apple.com ([17.250.248.87]:16847 "EHLO
	smtpout.mac.com") by vger.kernel.org with ESMTP id <S262932AbTC3BI0>;
	Sat, 29 Mar 2003 20:08:26 -0500
Date: Sun, 30 Mar 2003 11:19:56 +1000
Subject: Re: Kernel compile error with 2.5.66
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v551)
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
To: John Goerzen <jgoerzen@complete.org>
From: Stewart Smith <stewartsmith@mac.com>
In-Reply-To: <87brztwwaa.fsf@complete.org>
Message-Id: <B76E0B36-624D-11D7-9043-00039346F142@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.551)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, March 30, 2003, at 10:08  AM, John Goerzen wrote:
> This is on PowerPC:
> <snip>
> In file included from mm/fremap.c:14:
> include/linux/swapops.h: In function `pte_to_swp_entry':
> include/linux/swapops.h:54: warning: implicit declaration of function 
> `pte_file'
> mm/fremap.c:139: `PTE_FILE_MAX_BITS' undeclared (first use in this 
> function)

Yeap, I'm getting this too. There seems to be a whole bunch of changes 
in include/asm-ppc64/pgtable.h that aren't in include/asm-ppc/pgtable.h

This is at least my guess.
By doing the dumb cut&paste business I've gotten further along, but 
haven't done enough to actually compile fully yet. I'm half nervous 
about doing a lot of this as I have no idea about this level on ppc 
(maybe benh, the maintainer of linux for power mac could help out?).

If I get anything going, I'll let you know.

on an architectural question, there seems to be a lot of duplication 
between ppc and ppc64, should they be more closely melded or is there a 
really-good-reason(tm) behind the seperation?

------------------------------
Stewart Smith
stewartsmith@mac.com
Ph: +61 4 3884 4332
ICQ: 6734154

