Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTGKRPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTGKRPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:15:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35822 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S264499AbTGKRPK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:15:10 -0400
Subject: Re: 2.5 'what to expect'
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
References: <20030711140219.GB16433@suse.de>
	 <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Message-Id: <1057944829.6808.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 11 Jul 2003 10:33:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 07:26, Alan Cox wrote:

> or upgrade to rpm 4.2 (which I'd recommend everyone does anyway as it
> fixes a load of other problems) - ftp.rpm.org

I think the 2.5 problem is _only_ in rpm 4.2.

It looks like it is still in the latest version, too:

[10:32:41]root@phantasy:~# rpm -q rpm
rpm-4.2.1-0.11
[10:32:44]root@phantasy:~# rpm --rebuilddb
error: db4 error(16) from dbenv->remove: Device or resource busy

4.2 is fine, otherwise :)

	Robert Love


