Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWCCWDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWCCWDb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWCCWDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:03:31 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:1750 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751314AbWCCWDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:03:30 -0500
Subject: Re: SEEK_HOLE and SEEK_DATA support?
From: Nicholas Miell <nmiell@comcast.net>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jim Dennis <jimd@starshine.org>, linux-kernel@vger.kernel.org
In-Reply-To: <44088360.2030705@cfl.rr.com>
References: <20060303170417.GA26909@starshine.org>
	 <44088360.2030705@cfl.rr.com>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 14:03:28 -0800
Message-Id: <1141423408.2996.9.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 12:56 -0500, Phillip Susi wrote:
> Aren't there already apis to query for the holes in the file, 

Yes, but they are filesystem-specific. (I think only XFS has them at
this point.)

> and doesn't tar already use them to efficiently back up sparse files?

No (at least, not in GNU tar 1.15.1).

-- 
Nicholas Miell <nmiell@comcast.net>

