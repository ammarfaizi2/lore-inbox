Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbUAOQDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 11:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbUAOQDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 11:03:41 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:63997 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264510AbUAOQDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 11:03:40 -0500
Subject: Re: NTFS disk usage on Linux 2.6
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4006A904.3000307@bellsouth.net>
References: <20040115010210.GA570@s.chello.no>
	 <4006A904.3000307@bellsouth.net>
Content-Type: text/plain
Message-Id: <1074182621.12130.1.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 11:03:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-15 at 09:51, Craig Taylor wrote:
> Do a "properties" within Windows on the folder - windows will report the 
> _actual_ size of the file in it's listings, not the amount of space it 
> takes up. I presume that that's what is going on.

That's hardly going to account for a folder that is 2G LARGER than the
partition it lives on......

> >  12G     WINDOWS
> >
> >Same command on 2.4.24:
> >  1.4G    WINDOWS
> >
> >Compare the disk space used by the WINDOWS directory in the
> >two listings.  On 2.4.24, it correctly reports 1.4G, while
> >2.6.1 reports 12G, which is 2G more than the total space on
> >the filesystem.

-- 
Disconnect <lkml@sigkill.net>

