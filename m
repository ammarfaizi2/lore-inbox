Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318158AbSIAXIO>; Sun, 1 Sep 2002 19:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318159AbSIAXIO>; Sun, 1 Sep 2002 19:08:14 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:31985 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S318158AbSIAXIO>; Sun, 1 Sep 2002 19:08:14 -0400
Date: Sun, 1 Sep 2002 16:08:05 -0700
From: Chris Wright <chris@wirex.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Chris Wright <chris@wirex.com>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Greg KH <greg@kroah.com>, Gabor Kerenyi <wom@tateyama.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: extended file permissions based on LSM
Message-ID: <20020901160805.F11165@figure1.int.wirex.com>
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	Chris Wright <chris@wirex.com>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Greg KH <greg@kroah.com>, Gabor Kerenyi <wom@tateyama.hu>,
	linux-kernel@vger.kernel.org
References: <200208310616.04709.wom@tateyama.hu> <20020831095747.A781@nightmaster.csn.tu-chemnitz.de> <20020831172656.E11165@figure1.int.wirex.com> <E17lX4d-0004a1-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E17lX4d-0004a1-00@starship>; from phillips@arcor.de on Sun, Sep 01, 2002 at 05:55:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Phillips (phillips@arcor.de) wrote:
> On Sunday 01 September 2002 02:26, Chris Wright wrote:
> > * Ingo Oeser (ingo.oeser@informatik.tu-chemnitz.de) wrote:
> > > 
> > > So this is a correctly pointed out design weakness: The way the
> > > user took to reach the inode cannot be taken into account.
> > 
> > Yes, this is known, and there are anticipated VFS changes to remedy
> > this.
> 
> Could you describe them, please?

For example, passing vfsmount/dentry pair to i_op->permission().
getattr() is already done, and last I heard I Al intends to do
setattr() as well.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
