Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268654AbUHLS61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268654AbUHLS61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268659AbUHLS61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:58:27 -0400
Received: from quechua.inka.de ([193.197.184.2]:61134 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S268654AbUHLS6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:58:25 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: New concept of ext3 disk checks
Organization: Deban GNU/Linux Homesite
In-Reply-To: <411BAFCA.92217D16@orpatec.ch>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BvKmO-0002dn-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 12 Aug 2004 20:58:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <411BAFCA.92217D16@orpatec.ch> you wrote:
> - Instead of checks forced during startup checks are done during runtime
> (at low priority). It has to be determined if these checks are _only_
> checks or if they also include possible fixes. Possible solution might
> distinct between the severity of any discovered problem.

BTW: FreeBSD5 supports the fsck of a unclean filesystem in the background.
(Actually it supports to mount unclean filesystems because they are "always"
consistent and do reclaiming of unreferenced objects in a fsck in background
based on a snapshot)

I am not sure why the softupdates are so reliable, that no fsck is needed,
but I know it is pretty cool to do it in background only, especially for
notebooks. And I agree that background checks of long running systems may
catch problems - however I am not sure how a consitent FS view is best
created for that.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
