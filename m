Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbTEAPsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTEAPsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:48:21 -0400
Received: from 12-250-182-80.client.attbi.com ([12.250.182.80]:38919 "EHLO
	sonny.eddelbuettel.com") by vger.kernel.org with ESMTP
	id S261417AbTEAPsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:48:20 -0400
Date: Thu, 1 May 2003 11:00:39 -0500
From: Dirk Eddelbuettel <edd@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Tyan 2466 SMP locks hard with 2.4.20 + heavy disk i/o yet runs 2.2.* without problems
Message-ID: <20030501160039.GA20407@sonny.eddelbuettel.com>
References: <20030501135228.GA19643@sonny.eddelbuettel.com> <1051797371.21446.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051797371.21446.12.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 02:56:12PM +0100, Alan Cox wrote:
> On Iau, 2003-05-01 at 14:52, Dirk Eddelbuettel wrote:
> > Performance under 2.4.20 with ext3 + win4lin patch
> >   - "Stable" until disk-heavy operation causes freeze, typically within 
> >     two to three days
> >   - Heavy disk use (full backup writing, diff against big tarball, bonnie++) 
> >     freeze the machine hard, no ping, no sign of live
> >   + memtest86 shows no problem with the ram
> 
> If you don't have a PS/2 mouse plugged into the box add one. If that

My bad: I do have a PS/2 mouse plugged in.

> doens't help duplicate the crash without win4lin.

Good idea, will do and will try your most recent rc1-ac? as well. 

Thanks, Dirk

-- 
Don't drink and derive. Alcohol and algebra don't mix.
