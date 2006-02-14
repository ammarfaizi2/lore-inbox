Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422700AbWBNVJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbWBNVJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422701AbWBNVJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:09:10 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:24210 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422700AbWBNVJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:09:08 -0500
Subject: Re: Flames over -- Re: Which is simpler?
From: Lee Revell <rlrevell@joe-job.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <200602142141.10545.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0602141417350.1419-100000@iolanthe.rowland.org>
	 <200602142141.10545.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 16:08:58 -0500
Message-Id: <1139951339.11659.157.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 21:41 +0100, Rafael J. Wysocki wrote:
> [BTW, I wonder if it's USB-only, or some other subsystems behave
> in a similar way, like ieee1394 or external SATA.  And how about
> NFS/CIFS/whatever network filesystems mounted on the suspending box?]
> 

NFS is stateless, it does not care about stuff like this.  There's no
concept of an open file.  write() does not return until the data is
committed to stable storage.

Lee

