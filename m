Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268576AbUIQItz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268576AbUIQItz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 04:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268581AbUIQIty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 04:49:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39108 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268576AbUIQIts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 04:49:48 -0400
Date: Fri, 17 Sep 2004 10:43:06 +0200
From: Jens Axboe <axboe@suse.de>
To: James Cloos <cloos@jhcloos.com>
Cc: "Bc. Michal Semler" <cijoml@volny.cz>, linux-kernel@vger.kernel.org
Subject: Re: CD-ROM can't be ejected
Message-ID: <20040917084302.GA2911@suse.de>
References: <200409160025.35961.cijoml@volny.cz> <20040916070906.GK2300@suse.de> <200409160918.40767.cijoml@volny.cz> <20040916073616.GO2300@suse.de> <m3hdpx2t4d.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hdpx2t4d.fsf@lugabout.cloos.reno.nv.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17 2004, James Cloos wrote:
> I gave this program a try as well.
> 
> Eject has been failing on my laptop for quite a few kernel
> revisions.  Even using the keyboard's Fn+F10 fails.
> 
> Failures come with an extended beep -- 2 seconds or so --
> and a system pause (smbios I presume).
> 
> Your eject (edited only to use /dev/hdb) reports:
> 
> :; ~/src/jens-eject 
> command failed - sense 2/53/0

Exactly the same issue, read the thread - your tray is locked, because
someone else has the drive open.

-- 
Jens Axboe

