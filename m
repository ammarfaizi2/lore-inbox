Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266851AbUBEVeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266811AbUBEVc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:32:26 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:17024 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266530AbUBEVcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:32:07 -0500
Date: Thu, 5 Feb 2004 21:41:32 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402052141.i15LfWUk000377@81-2-122-30.bradfords.org.uk>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040205211633.GH10547@stud.uni-erlangen.de>
References: <20040205203336.GE10547@stud.uni-erlangen.de>
 <20040205205421.GE11683@suse.de>
 <20040205211633.GH10547@stud.uni-erlangen.de>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I still think this is to be expected when mucking in undefined teritory.
> > Reload the media, it's not hard... Sure you can get around this with
> > snooping if you really wanted to, but IMO it's wasted effort. Add -eject
> > to cdrecord command line of default config, how you want so solve it is
> > not my problem.
> 
> I don't understand why the Linux kernel doesn't simply invalidates the
> buffers when a CDROM media is unmounted. If this would be case no such
> problems would ever occur.

At a guess, it might be a hack intended to increase performance for CD
jukeboxes where only one disc can be mounted at a time.

John.
