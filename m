Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752136AbWCJBOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbWCJBOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWCJBOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:14:12 -0500
Received: from quechua.inka.de ([193.197.184.2]:35235 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1752136AbWCJBOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:14:10 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [Ocfs2-devel] Ocfs2 performance
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060310002121.GJ27280@ca-server1.us.oracle.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FHWCm-0002rT-00@calista.inka.de>
Date: Fri, 10 Mar 2006 02:14:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh <mark.fasheh@oracle.com> wrote:
> Your hash sizes are still ridiculously large.

How long are those entries in the buckets kept? I mean if I untar a tree the
files are only locked while extracted, afterwards they are owner-less... (I
must admint I dont understand ocfs2 very deeply, but maybe explaining why so
many active locks need to be cached might help to find an optimized way.

> By the way, an interesting thing happened when I recently switched disk
> arrays - the fluctuations in untar times disappeared. The new array is much
> nicer, while the old one was basically Just A Bunch Of Disks. Also, sync
> times dropped dramatically.

Writeback Cache?

Gruss
Bernd
