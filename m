Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266088AbRGLLwN>; Thu, 12 Jul 2001 07:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266094AbRGLLwD>; Thu, 12 Jul 2001 07:52:03 -0400
Received: from u-83-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.83]:37103
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S266088AbRGLLvz>; Thu, 12 Jul 2001 07:51:55 -0400
Date: Thu, 12 Jul 2001 12:12:45 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: "C. Slater" <cslater@wcnet.org>, linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
Message-ID: <20010712121245.C2502@bacchus.dhis.org>
In-Reply-To: <002201c10a59$e5ef0ae0$7fcdae3f@laptop> <200107112344.f6BNijh2010363@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107112344.f6BNijh2010363@webber.adilger.int>; from adilger@turbolinux.com on Wed, Jul 11, 2001 at 05:44:45PM -0600
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 05:44:45PM -0600, Andreas Dilger wrote:

> The best proposal I've heard so far was to use MOSIX to do live job
> migration between machines, and then upgrade the kernel like normal.
> In the end, it is the jobs that are running on the kernel, and not
> the kernel or the individual machine that are the most important.  One
> person pointed out that there is a single point of failure in the
> MOSIX "stub" machine, which doesn't help you in the end (how do you
> update the kernel there?).  If you can figure a way to enhance MOSIX
> to allow migrating the MOSIX "stub" processes to another machine, you
> will have solved your problem in a much easier way, IMHO.

Virtual machines a la VM are also nice for this.  Build a HA cluster from
two VMs, then upgrade one after another.  All that's required is HA stuff
as it already is available.

  Ralf
