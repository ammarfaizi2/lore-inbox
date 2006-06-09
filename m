Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWFISuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWFISuw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbWFISuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:50:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:55917 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030288AbWFISuv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:50:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=JFKRLrZ8pWQZ6Epa7vDZe8OTVZyxd2HSNapXQpsICKDh/st2KeS/LRpepG1gSvMlugg8zn4AOiRHC8uPnajL8IgKSJoPW2H0E2GmWlFqsxUT+Qwzot/xradlgwjgPOVu0JmN5PY63OAETZwz/9/aLF6uWtqVLtE3xUktW7SnTIw=
Date: Fri, 9 Jun 2006 20:50:00 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: torvalds@osdl.org, adilger@clusterfs.com, alex@clusterfs.com,
       jeff@garzik.org, akpm@osdl.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-Id: <20060609205000.fce57f54.diegocg@gmail.com>
In-Reply-To: <m31wty9o77.fsf@bzzz.home.net>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org>
	<448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	<20060609181020.GB5964@schatzie.adilger.int>
	<Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
	<m31wty9o77.fsf@bzzz.home.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 09 Jun 2006 22:30:20 +0400,
Alex Tomas <alex@clusterfs.com> escribió:


>  LT> See? ext3 would become strictly _worse_ for the majority of users, who 
>  LT> wouldn't get any advantage. That's my point.
> 
> would "#if CONFIG_EXT3_EXTENTS" be a good solution then?

Not at all, a config option may be disabled by lots of distros
and make backwards compatibility even more difficult than
is already going to be.
