Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266550AbUHSPgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbUHSPgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUHSPgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:36:04 -0400
Received: from smtp.terra.es ([213.4.129.129]:17552 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id S266498AbUHSPaE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:30:04 -0400
Date: Thu, 19 Aug 2004 14:06:59 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Lee Revell <rlrevell@joe-job.com>
Cc: diablod3@gmail.com, kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org,
       schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040819140659.6f61edcd.diegocg@teleline.es>
In-Reply-To: <1092915160.830.9.camel@krustophenia.net>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	<d577e5690408190004368536e9@mail.gmail.com>
	<1092915160.830.9.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 19 Aug 2004 07:32:40 -0400 Lee Revell <rlrevell@joe-job.com> escribió:

> On Thu, 2004-08-19 at 03:04, Patrick McFarland wrote:
> > If no one has noticed yet, thanks to the additional license
> > restrictions Joerg Schilling has added to cdrecord (due to this
> > thread), it may be now moved to non-free in Debian in the near future.
> 
> What restrictions?  Do you have a link?

See http://weblogs.mozillazine.org/gerv/archives/006193.html (which may not
be the best interpretation of the changes)

Basically it was added a "linuxcheck" function which you're not allowed to
modify or delete. The function has a "warning", which results in something
like:
cdrecord: Warning: Running on Linux-2.6.8
cdrecord: There are unsettled issues with Linux-2.5 and newer.
cdrecord: If you have unexpected problems, please try Linux-2.4 or Solaris.

(Dunno what it prints out when you're running suse but I don't think linux
vendors are going to distribute software which says that their own software
has issues.)
