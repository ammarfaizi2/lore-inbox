Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266961AbUBGPU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 10:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266964AbUBGPU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 10:20:29 -0500
Received: from linux.us.dell.com ([143.166.224.162]:10191 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S266961AbUBGPUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 10:20:23 -0500
Date: Sat, 7 Feb 2004 09:20:08 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Clay Haapala <chaapala@cisco.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib routines
Message-ID: <20040207092008.A29036@lists.us.dell.com>
References: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com> <Xine.LNX.4.44.0402031213120.939-100000@thoron.boston.redhat.com> <20040203175006.GA19751@chaapala-lnx2.cisco.com> <20040203185111.GA31138@waste.org> <yqujad40j7rn.fsf@chaapala-lnx2.cisco.com> <20040203172508.B26222@lists.us.dell.com> <20040203233737.GD31138@waste.org> <yquj4qu6g6ui.fsf@chaapala-lnx2.cisco.com> <20040204172116.GF31138@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040204172116.GF31138@waste.org>; from mpm@selenic.com on Wed, Feb 04, 2004 at 11:21:16AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 11:21:16AM -0600, Matt Mackall wrote:
> As has been pointed out, _not_ putting some sort of license on it
> potentially opens people who ship it up to liability. Arguably, by
> compiling it into the kernel, you're accepting the GPL liability terms
> for that use. But that doesn't stop someone from taking crc32.c,
> incorporating it into something else, having it blow up disastrously,
> and then suing whoever sold them the kernel tarball. Sounds
> outlandish, but crazier things have happened.
> 
> As "dual GPL/public domain license" is an oxymoron, the best thing to
> do is probably to slap a dual GPL/2-clause BSD license on it to
> disclaim liability while minimally limiting all other rights. Matt,
> since you're the last one to touch this, I'll let you make the call,
> but here's what I would suggest (still needs an actual copyright
> notice):

Thanks for the dual-license BSD/GPL patch Matt.
Before proceeding with accepting your patch, I'm asking our Dell IP
legal team for advice, just to be safe.  IANAL, most of us aren't,
they are.  I'll send a follow-up soon as I hear back, probably early
next week.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
