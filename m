Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUAORYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 12:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUAORYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 12:24:48 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:21429 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S265224AbUAORYr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 12:24:47 -0500
Date: Thu, 15 Jan 2004 12:24:46 -0500 (EST)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
In-Reply-To: <4006C665.3065DFA1@users.sourceforge.net>
Message-ID: <Pine.GSO.4.58.0401151215320.27227@denali.ccs.neu.edu>
References: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>
 <4006C665.3065DFA1@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Jan 2004, Jari Ruusu wrote:

> Jim,
> If you want your data secure, you need to re-encrypt your data anyway.
> Mainline loop crypto implementation has exploitable vulnerability that is
> equivalent to back door. Kerneli.org folks have always shipped back-doored
> loop crypto, and now mainline folks are shipping back-doored loop crypto.
> Kerneli.org derivatives such as Debian, SuSE, and others are also
> back-doored.

Hi Jari,

Could you give me more information about this back-door, and generally
speaking how it would be exploited?  I want to be sure that I am affected
by this problem.

Also, in the loop-AES.README, this is mentioned:

"Device backed loop device can be used with journaling file systems as
device backed loops guarantee that writes reach disk platters in
order required by journaling file system (write caching must be disabled
on the disk drive, of course)"

Are you talking about the "hdparm -W" flag for IDE drives?  Would I need
to disable write caching when using non-journaling file systems?

thanks,
Jim Faulkner
