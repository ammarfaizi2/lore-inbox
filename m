Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261623AbTCZSh2>; Wed, 26 Mar 2003 13:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbTCZSh2>; Wed, 26 Mar 2003 13:37:28 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:6117 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S261623AbTCZSh0>; Wed, 26 Mar 2003 13:37:26 -0500
Date: Wed, 26 Mar 2003 10:47:23 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Erik Hensema <erik@hensema.net>, linux-kernel@vger.kernel.org
Subject: Re: LVM/Device mapper breaks with -mm (was: Re: 2.5.66-mm1)
Message-ID: <20030326184723.GM19670@ca-server1.us.oracle.com>
References: <20030326013839.0c470ebb.akpm@digeo.com> <slrnb8373s.19a.usenet@bender.home.hensema.net> <20030326134834.GA11173@win.tue.nl> <slrnb83ehl.196.usenet@bender.home.hensema.net> <20030326160350.GA11190@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326160350.GA11190@win.tue.nl>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 05:03:50PM +0100, Andries Brouwer wrote:
> With sufficiently recent user space utilities all
> should work: they can find out the interface version
> using the DM_VERSION ioctl, and then adapt what
> they send to the kernel.

	We need to start tracking down what userspace needs fixing
still.  We also should iron out our representations.  eg, hpa's
recommendation for 64bits, or the 12/20 split for 32bit, or etc.

Joel


-- 

Life's Little Instruction Book #451

	"Don't be afraid to say, 'I'm sorry.'"

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
