Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTKAB5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 20:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbTKAB5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 20:57:37 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:16655
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262434AbTKAB5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 20:57:36 -0500
Date: Fri, 31 Oct 2003 17:57:33 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Jeffrey E. Hundstad" <jeffrey@hundstad.net>
Cc: Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: Something corrupts raid5 disks slightly during reboot
Message-ID: <20031101015733.GA3907@matchmail.com>
Mail-Followup-To: "Jeffrey E. Hundstad" <jeffrey@hundstad.net>,
	Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
References: <20031031190829.GM4868@niksula.cs.hut.fi> <3FA30F4A.5030500@hundstad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA30F4A.5030500@hundstad.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 07:41:30PM -0600, Jeffrey E. Hundstad wrote:
> Try:
> 
> hdparm -W0 /dev/hdX
> 
> for each of your ide drives.  This turns off write-caching which is 
> usually a bad thing with ide drives anyway.
> 

Also try installing smartmontools, and run smartmon -a on each of the
drives.  It might tell you one of the drives is going bad...
