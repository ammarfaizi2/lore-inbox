Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263517AbTC3DE0>; Sat, 29 Mar 2003 22:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263511AbTC3DE0>; Sat, 29 Mar 2003 22:04:26 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:62205 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S263510AbTC3DEY>; Sat, 29 Mar 2003 22:04:24 -0500
Date: Sat, 29 Mar 2003 19:13:41 -0800
From: Chris Wright <chris@wirex.com>
To: Shaya Potter <spotter@yucs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: process creation/deletions hooks
Message-ID: <20030329191341.B28410@figure1.int.wirex.com>
Mail-Followup-To: Shaya Potter <spotter@yucs.org>,
	linux-kernel@vger.kernel.org
References: <1048799290.31010.62.camel@zaphod> <20030328180303.A26128@figure1.int.wirex.com> <1048989040.32227.126.camel@zaphod> <20030329175208.A28410@figure1.int.wirex.com> <1048989675.32227.128.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1048989675.32227.128.camel@zaphod>; from spotter@yucs.org on Sat, Mar 29, 2003 at 09:01:15PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Shaya Potter (spotter@yucs.org) wrote:
> the main issue w/ this is that this doesn't support multiple things
> using the hooks.

it's possible for multiple modules to use the hooks.  the interface
can support it at least.  there are some issues with sharing the
security label in the task_struct, but nothing insurmountable.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
