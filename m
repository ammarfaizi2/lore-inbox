Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbTBNSP3>; Fri, 14 Feb 2003 13:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbTBNSP3>; Fri, 14 Feb 2003 13:15:29 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:3560 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S263977AbTBNSP1>; Fri, 14 Feb 2003 13:15:27 -0500
Date: Fri, 14 Feb 2003 20:25:16 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: modutils that works with 2.4 and 2.5?
Message-ID: <20030214182516.GG3632@actcom.co.il>
References: <1045162343.1311.7.camel@mentor> <20030214060024.GC9578@actcom.co.il> <1045246324.1301.1.camel@mentor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045246324.1301.1.camel@mentor>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 11:12:03AM -0700, Dax Kelson wrote:
> On Thu, 2003-02-13 at 23:00, Muli Ben-Yehuda wrote:
> > On Thu, Feb 13, 2003 at 11:52:23AM -0700, Dax Kelson wrote:
> > > Does such a thing exist?
> > > 
> > > I would like to help out testing 2.5, but I need to still use 2.4 as
> > > well.
> > 
> > Rusty's modutils package maintains the old modutils binaries and falls
> > back to them if it discovers that you're running a 2.4 system.
> 
> Does it do this discovery at install time, or at each boot?

Each invocation, I suppose. Doesn't make much sense otherwise. 

see for example lsmod.c, main() -> try_old_version(). 
-- 
Muli Ben-Yehuda
http://www.mulix.org
http://syscalltrack.sf.net

