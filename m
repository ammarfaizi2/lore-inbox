Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267083AbUBMQMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267087AbUBMQMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:12:31 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12418 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267083AbUBMQMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:12:24 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: harddisk or kernel problem?
Date: Fri, 13 Feb 2004 17:17:34 +0100
User-Agent: KMail/1.5.3
References: <20040213075403.GC1881@schottelius.org> <20040213081104.GD1881@schottelius.org> <20040213095223.GE1881@schottelius.org>
In-Reply-To: <20040213095223.GE1881@schottelius.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402131717.34917.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 of February 2004 10:52, Nico Schottelius wrote:
> Nico Schottelius [Fri, Feb 13, 2004 at 09:11:04AM +0100]:
> > forgot the config and the dmesg..
>
> Now additionally I found a mistake in my thoughts:
>
> hda/part3 makes the errors, hda/part4 is the cryptoloop partition.
> So in fact the error occurs when mounting this particular partition, but
> seems to be an error on partition3. Can someone give me a hint on what
> todo?

Check your disk with SMART tools: http://smartmontools.sf.net.

