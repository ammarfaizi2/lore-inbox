Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291687AbSBHRsO>; Fri, 8 Feb 2002 12:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291678AbSBHRsE>; Fri, 8 Feb 2002 12:48:04 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:24317
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291676AbSBHRrq>; Fri, 8 Feb 2002 12:47:46 -0500
Date: Fri, 8 Feb 2002 09:47:30 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Fix for duplicate /proc entries
Message-ID: <20020208174730.GA343@mis-mike-wstn>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202072243560.26015-100000@Appserv.suse.de> <20020208094911.F7930-100000@ozma.union.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020208094911.F7930-100000@ozma.union.utexas.edu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 10:13:26AM -0600, Brent Cook wrote:
> Maybe, someday there will be some sort of DEBUG flag to set in the kernel,
> from which a slew of asserts and printk's will spring to life, pointing
> out inconsistencies and bad assumptions. That is where this check would
> probably work the best.
> 

Actually, there are seperate debug config options for different subsystems,
and I think that is good.  The real problem is finding a way to add another
debug config option for procfs without littering the code with ifdefs...

Mike
