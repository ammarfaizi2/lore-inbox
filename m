Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318243AbSG3MTc>; Tue, 30 Jul 2002 08:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318244AbSG3MTc>; Tue, 30 Jul 2002 08:19:32 -0400
Received: from 209-166-240-202.cust.walrus.com.240.166.209.in-addr.arpa ([209.166.240.202]:62891
	"EHLO ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id <S318243AbSG3MTb>; Tue, 30 Jul 2002 08:19:31 -0400
Date: Tue, 30 Jul 2002 08:22:45 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Testing of filesystems
Message-ID: <20020730082245.A1590@ti18>
References: <20020730094902.GA257@prester.freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20020730094902.GA257@prester.freenet.de>; from axel@hh59.org on Tue, Jul 30, 2002 at 11:49:02AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 11:49:02AM +0200, Axel Siebenwirth wrote:
> I wonder what a good way is to stress test my JFS filesystem. Is there a tool
> that does something like that maybe? Dont't want performance testing, just
> all kinds of stress testing to see how the filesystem "is" and to check
> integrity and functionality.

See the ext3 cvs tree at 

   http://sourceforge.net/projects/gkernel

[Jeff Garzik's CVS tree hosts the ext3 tree.]

Andrew Morton, being conscientious and methodical, has written lots of
filesystem testing tools during his work on ext3.  Some of these tests
are for specific ext3 regressions, but many are useful as general
integrity tests oriented toward journalled filesystems.  He has also
ported/improved several other tools, including a bunch of changes to
the notorious FSX, the File System eXerciser.

The Namesys folks also have a test suite for Reiserfs, see www.namesys.com.

Regards,

   Bill Rugolsky
