Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTKOUxt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 15:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTKOUxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 15:53:49 -0500
Received: from wblv-224-88.telkomadsl.co.za ([165.165.224.88]:24449 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262104AbTKOUwU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 15:52:20 -0500
Subject: Re: Carrier detection for network interfaces
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <3FB68F59.1050909@pobox.com>
References: <1068912989.5033.32.camel@nosferatu.lan>
	 <3FB652BA.1010905@pobox.com> <1068928120.5033.34.camel@nosferatu.lan>
	 <3FB68F59.1050909@pobox.com>
Content-Type: text/plain
Message-Id: <1068929620.5033.36.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 15 Nov 2003 22:53:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-11-15 at 22:40, Jeff Garzik wrote:
> Martin Schlemmer wrote:
> > On Sat, 2003-11-15 at 18:22, Jeff Garzik wrote:
> > 
> >>Martin Schlemmer wrote:
> >>
> >>>Is there any proper way to detect a carrier signal with network
> >>>interfaces ?  I have recently come across a problem where we tried
> >>>to do with with checking for 'RUNNING', which do not work for all
> >>>drivers, as well as mii-tool that fails in some cases.
> >>
> >>
> >>What kernel version?
> >>
> >>In 2.6 you have linkwatch.  In 2.4 and 2.6, you have ETHTOOL_GLINK, and 
> >>mii-tool.
> >>
> > 
> > 
> > Anything more shell accessible (sysfs/proc) ?
> 
> 
> ethtool is shell accessible.
> 

Yep, thanks.  Was just wondering if there was a way
that did not depend on additional tools beyond cat,
sed, grep, etc.


Thanks,

-- 
Martin Schlemmer

