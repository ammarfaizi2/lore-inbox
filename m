Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbTJESWV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 14:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTJESWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 14:22:21 -0400
Received: from quechua.inka.de ([193.197.184.2]:60342 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263316AbTJESWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 14:22:20 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: swap and 2.4.20
Organization: Deban GNU/Linux Homesite
In-Reply-To: <Pine.LNX.4.44.0310051559340.5605-100000@gaia.cela.pl>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.1-20030907 ("Sandray") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E1A6DVX-0007dB-00@calista.inka.de>
Date: Sun, 05 Oct 2003 20:21:27 +0200
X-Scanner: exiscan *1A6DVX-0007dB-00*zNmqf8i1G0g*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0310051559340.5605-100000@gaia.cela.pl> you wrote:
> I have a different - slightly academic - question.  Is it possible to turn
> off swapping? (not turn off swap)  Ie. to prevent the kernel from
> unloading paged-in read-only executables?  I realise this is a tough
> question with mmap being used for many other things besides executables...

I think you mean paging? Read Only executable pages mapped to executables
will not be put/read from swap.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
