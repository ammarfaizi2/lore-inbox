Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTHZSyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbTHZSyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:54:47 -0400
Received: from ns1.beeonline.ru ([195.58.40.10]:5650 "EHLO
	bolsmtpdns1.beeonline.internal") by vger.kernel.org with ESMTP
	id S262623AbTHZSyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:54:43 -0400
Date: Tue, 26 Aug 2003 22:41:15 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Steven Cole <elenstev@mesatop.com>, Oleg Drokin <green@namesys.com>,
       reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org, demidov <demidov@namesys.com>,
       god@namesys.com
Subject: Re: reiser4 snapshot for August 26th.
Message-ID: <20030826184114.GP5448@backtop.namesys.com>
References: <20030826102233.GA14647@namesys.com> <1061922037.1670.3.camel@spc9.esa.lanl.gov> <3F4BA9E9.4090108@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4BA9E9.4090108@namesys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 10:41:45PM +0400, Hans Reiser wrote:
> Mr. Demidov, if you put code that does not compile into our tree you 
> need to make the config option for it be invisible.

There is such an option already, CONFIG_REISER4_FS_SYSCALL, 
seems it is off by default.

> 
> Yes?
> 
> Steven, try turning off the sys_reiser4 related code.
> 
> Nikita, if Demidov is not workingtoday (I notice the lack of timesheet 
> commits recently), take care of this for him.
> 
> Hans
> 
> Steven Cole wrote:
> 
> >On Tue, 2003-08-26 at 04:22, Oleg Drokin wrote:
> > 
> >
> >>Hello!
> >>
> >>  I have just released another reiser4 snapshot that I hope all interested
> >>  parties will try. It is released against 2.6.0-test4.
> >>  You can find it at http://namesys.com/snapshots/2003.08.26
> >>  I include release notes below.
> >>
> >>Reiser4 snapshot for 2003.08.26
> >>
> >>   
> >>
> >
> >I got this error while attempting to compile with reiser4.
> >Snippet from .config follows.
> >
> >Steven
> >
> > CC      fs/reiser4/plugin/file/tail_conversion.o
> > CC      fs/reiser4/sys_reiser4.o
> >fs/reiser4/sys_reiser4.c:54:32: parser/parser.code.c: No such file or 
> >directory
> >fs/reiser4/sys_reiser4.c: In function `sys_reiser4':
> >fs/reiser4/sys_reiser4.c:75: warning: implicit declaration of function 
> >`reiser4_pars_init'
> >fs/reiser4/sys_reiser4.c:75: warning: assignment makes pointer from 
> >integer without a cast
> >fs/reiser4/sys_reiser4.c:80: error: dereferencing pointer to incomplete 
> >type
> >fs/reiser4/sys_reiser4.c:82: warning: implicit declaration of function 
> >`yyparse'
> >fs/reiser4/sys_reiser4.c:83: warning: implicit declaration of function 
> >`reiser4_pars_free'
> >fs/reiser4/sys_reiser4.c:66: warning: unused variable `Gencode'
> >fs/reiser4/sys_reiser4.c: At top level:
> >fs/reiser4/parser/parser.h:333: warning: `Fistmsg' defined but not used
> >fs/reiser4/parser/parser.h:342: warning: `typesOfCommand' defined but not 
> >used
> >fs/reiser4/parser/parser.h:354: warning: `Code' defined but not used
> >make[2]: *** [fs/reiser4/sys_reiser4.o] Error 1
> >make[1]: *** [fs/reiser4] Error 2
> >make: *** [fs] Error 2
> >[steven@spc1 linux-2.6.0-test4-r4]$ grep REISER4 .config
> >CONFIG_REISER4_FS=y
> >CONFIG_REISER4_FS_SYSCALL=y
> >CONFIG_REISER4_LARGE_KEY=y
> ># CONFIG_REISER4_CHECK is not set
> >CONFIG_REISER4_USE_EFLUSH=y
> ># CONFIG_REISER4_BADBLOCKS is not set
> >
> >
> >
> >
> > 
> >
> 
> 
> -- 
> Hans
> 
> 

-- 
Alex.
