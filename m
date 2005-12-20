Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVLTVpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVLTVpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVLTVpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:45:44 -0500
Received: from lixom.net ([66.141.50.11]:39582 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S932140AbVLTVpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:45:44 -0500
Date: Tue, 20 Dec 2005 15:45:25 -0600
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: console on POWER4 not working with 2.6.15
Message-ID: <20051220214525.GB7428@pb15.lixom.net>
References: <20051220204530.GA26351@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220204530.GA26351@suse.de>
User-Agent: Mutt/1.5.9i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 09:45:30PM +0100, Olaf Hering wrote:
> The connection of ttyS0 to /dev/console doesnt seem to work anymore mit
> 2.6.15-rc5+6 on a POWER4 p630 in fullsystempartition mode, no HMC
> connected. It works with 2.6.14.4.
> I tested 2.6.15-rc6 arch/powerpc/configs/ppc64_defconfig.

It seems to have been broken a while: According to test.kernel.org (last
machine in the matrix is an SMP mode p650), it broke between 2.6.14-git2
and 2.6.14-git3. Console output can be found in:

http://test.kernel.org/15622/debug/console.log   for the failed one
http://test.kernel.org/15530/debug/console.log   for the successful one


-Olof
