Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262949AbVALADf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVALADf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbVAKXif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:38:35 -0500
Received: from quechua.inka.de ([193.197.184.2]:1213 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262925AbVAKXgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:36:42 -0500
From: Bernd Eckenfels <ecki-news2005-01@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux NFS vs NetApp
Organization: Deban GNU/Linux Homesite
In-Reply-To: <16868.19707.857446.864762@cse.unsw.edu.au>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CoVZ2-0006f7-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 12 Jan 2005 00:36:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <16868.19707.857446.864762@cse.unsw.edu.au> you wrote:
>> NetApp's WAFL only journals metadata in NVRAM ...
>> (one of the primary reasons its called WAFL is that the data-write only 
>> happens once..).

> That may be, though it doesn't fit with my (admittedly limitted)
> understanding of WAFL.

Yes, AFAIK the NVRAM is used for the RAID-4, independend of WAFL and  as a write-back cache. 

However since also the read performance of Linux NFS is bad (at least not
very well selftuning) the Hardware is not really the reason for the fast NFS
implementation.

Greetings
Bernd
