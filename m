Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTLYO70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 09:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbTLYO70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 09:59:26 -0500
Received: from [66.98.192.92] ([66.98.192.92]:16288 "EHLO svr44.ehostpros.com")
	by vger.kernel.org with ESMTP id S264308AbTLYO7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 09:59:25 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Daniel Jacobowitz <dan@debian.org>
Subject: Re: KGDB: automatic loading of modules in gdb
Date: Thu, 25 Dec 2003 20:29:14 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200312231818.03072.amitkale@emsyssoft.com> <20031224173205.GA27219@nevyn.them.org>
In-Reply-To: <20031224173205.GA27219@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312252029.14667.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am going to be sending these patches to gdb developers also for 
review/feedback. I'll work on this feature myself for gdb.

On Wednesday 24 Dec 2003 11:02 pm, Daniel Jacobowitz wrote:
> On Tue, Dec 23, 2003 at 06:18:02PM +0530, Amit S. Kale wrote:
> > Hi,
> >
> > I have integrated a couple of kgdb features from TimeSys Linux
> > distribution.
> >
> > 1.  Automatic loading of module files in gdb:
> > A special version of gdb is provided with this feature. It can detect
> > loading and unloading of modules in a kernel. Whenever a module is
> > loaded, gdb loads the module object file and makes it available for
> > debugging. loadmodule.sh script is no longer needed.
>
> Have you or TimeSys, oh, I don't know, considered sending information
> about this feature to the GDB developers so that KGDB does not require
> a custom version of the GDB client?

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

