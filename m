Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTC1B6J>; Thu, 27 Mar 2003 20:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261920AbTC1B6J>; Thu, 27 Mar 2003 20:58:09 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:130 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261908AbTC1B6I>; Thu, 27 Mar 2003 20:58:08 -0500
Date: Fri, 28 Mar 2003 02:08:56 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Joel Becker <Joel.Becker@oracle.com>, Erik Hensema <erik@hensema.net>,
       linux-kernel@vger.kernel.org
Subject: Re: LVM/Device mapper breaks with -mm (was: Re: 2.5.66-mm1)
Message-ID: <20030328020856.GB22072@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Joel Becker <Joel.Becker@oracle.com>,
	Erik Hensema <erik@hensema.net>, linux-kernel@vger.kernel.org
References: <20030326013839.0c470ebb.akpm@digeo.com> <slrnb8373s.19a.usenet@bender.home.hensema.net> <20030326134834.GA11173@win.tue.nl> <slrnb83ehl.196.usenet@bender.home.hensema.net> <20030326160350.GA11190@win.tue.nl> <20030326184723.GM19670@ca-server1.us.oracle.com> <20030326205228.GA11217@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326205228.GA11217@win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 09:52:28PM +0100, Andries Brouwer wrote:

 > For example, struct umsdos_ioctl has twice dev_t followed
 > by padding. Probably these should become unsigned longs.
 > I'll send a patch later tonight.
 > 
 > Is it used anywhere? That requires detective work.
 > It is used by the utilities udosctl (a useless demo utility),
 > umssync and umssetup. I do not know of any others.
 > No doubt people will tell me what I overlooked.
 > Less conservative people will tell me that umsdos has to
 > be killed entirely.

Isn't it still horribly broken ? I remember Al putting it on
the "To be fixed later" burner, but never saw anything happen
to it after that asides from janitor style fixes.

		Dave

