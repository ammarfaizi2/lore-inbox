Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbUCHKPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 05:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUCHKPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 05:15:30 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:35298 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262436AbUCHKPW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 05:15:22 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Mon, 8 Mar 2004 15:45:09 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, george@mvista.com,
       pavel@ucw.cz
References: <200403081504.30840.amitkale@emsyssoft.com> <20040308015433.5424cc52.akpm@osdl.org>
In-Reply-To: <20040308015433.5424cc52.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403081545.09916.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Mar 2004 3:24 pm, Andrew Morton wrote:
> "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > Here is kgdb for mainline kernel in three patches.
>
> Thanks for working on this.

Credits go to all the kgdb developers.

>
> > This is a lite
> >  version of kgdb available from kgdb.sourceforge.net. I believe that all
> > of us agree on this lite kgdb.
>
> What is "lite" about it?  As in, what features have been removed?

Here are features that are present only in full kgdb:
1. Thread support  (aka info threads)
2. console messages through gdb
3. Automatic loading of modules in gdb
4. Support for x86_64
5. Support for powerpc
6. kgdb over ethernet [This isn't ready in the full version as well at this 
point of time]

-Amit

>
> >  It supports basic debugging of i386 architecture and debugging over a
> > serial line. Contents of these patches are as follows:
> >
> >  [1] core-lite.patch: architecture indepndent code
> >  [2] i386-lite.patch: i386 architecture dependent code
> >  [3] 8250.patch: support for generic serial driver
>
> What is the story on kgdboe?

