Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261496AbSJDLhP>; Fri, 4 Oct 2002 07:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbSJDLhP>; Fri, 4 Oct 2002 07:37:15 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:33802 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261496AbSJDLhO>; Fri, 4 Oct 2002 07:37:14 -0400
Date: Fri, 4 Oct 2002 12:42:47 +0100
From: John Levon <levon@movementarian.org>
To: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
Message-ID: <20021004114247.GA98207@compsoc.man.ac.uk>
References: <20021003153943.E22418@openss7.org> <20021003221525.GA2221@kroah.com> <20021003222716.GB14919@suse.de> <1033684027.1247.43.camel@phantasy> <20021003233504.GA20570@suse.de> <20021003235022.GA82187@compsoc.man.ac.uk> <mailman.1033691043.6446.linux-kernel2news@redhat.com> <200210040403.g9443Vu03329@devserv.devel.redhat.com> <20021003233221.C31444@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003233221.C31444@openss7.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 11:32:21PM -0600, Brian F. G. Bidulock wrote:

> You do know that there *is* open source code which is not
> contained in the Linux kernel ;)

I think the fact that downloading the kernel source, applying a patch,
fixing the conflicts, and rebooting, can be a significant PITA for
admin/developers has completely passed them by.

> development kernels only), because the symbol is no longer
> exported and no registration procedure was provided for
> registering otherwise non-implemented system calls (in
> particular the UNIX98 and iBCS/ABI standard putmsg/getmsg
> calls).

Look, why don't you submit the module-loading patch for LiS already ?

Btw, anybody know what the BKL is actually protecting against in
sys_nfsservctl ?

> And what about AFS?  I see that it uses a sys_ni_syscall slot as
> well...

I thought it got fixed last time round.

regards
john

-- 
"Me and my friends are so smart, we invented this new kind of art:
 Post-modernist throwing darts"
	- the Moldy Peaches
