Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbTLRL0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 06:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbTLRL0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 06:26:09 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:15564 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S265080AbTLRL0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 06:26:05 -0500
Date: Thu, 18 Dec 2003 12:25:43 +0100
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Can't bk clone linux-2.5
Message-ID: <20031218112543.GA10230@neon>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031218104348.GA9007@neon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218104348.GA9007@neon>
Organization: pearbough.net
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi linux-kernel!

On Thu, 18 Dec 2003, Axel Siebenwirth wrote:

> Hi,
> 
> I'm lost. I cannot clone linux-2.5 bk tree.
> 
> I am in an empty directory. Then I do:
> 
> bk clone http://linux.bkbits.net/linux-2.5 linus-2.5                                                                                
> Clone http://linux.bkbits.net/linux-2.5
>    -> file://usr/local/src/kernel/linus-2.5
> 14 bytes uncompressed to 10, 0.71X expansion
> Looking for, and removing, any uncommitted deltas...
> Set parent to http://linux.bkbits.net/linux-2.5
> Running consistency check ...
> get: couldn't open SCCS/s.ChangeSet
> get: No such file: SCCS/s.ChangeSet
> sfiles: can't init ChangeSet: No such file or directory
> idcache: No such file or directory
> Consistency check failed, repository left locked.
> WARNING: deleting orphan file /tmp/bk_clone2_gdZWv7
> Exit 1


Doing a "bk pull" on an existing repository results in an error as well.
Is it just me?

bk pull
Pull http://linux.bkbits.net/linux-2.5
  -> file://usr/local/src/system/kernel/linus-2.5
---------------------- Receiving the following csets -----------------------
1.1533 1.1532 1.1531 1.1530 1.1529 1.1515.1.8 1.1515.1.7
1.1515.1.6 1.1515.1.5 1.1515.1.4 1.1515.1.3 1.1528 1.1527
1.1526 1.1525 1.1524 1.1523 1.1522 1.1521 1.1520 1.1519
1.1518 1.1517 1.1516
----------------------------------------------------------------------------
Expected '== f =='
GOT: # Patch checksum=f8850b70
==============================================================================

186 bytes uncompressed to 227, 1.22X expansion
Exit 1


Regards,
Axel
