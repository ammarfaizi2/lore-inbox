Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVAVKJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVAVKJi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 05:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVAVKJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 05:09:37 -0500
Received: from levante.wiggy.net ([195.85.225.139]:40119 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262688AbVAVKJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 05:09:36 -0500
Date: Sat, 22 Jan 2005 11:09:33 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: negative diskspace usage
Message-ID: <20050122100933.GM7147@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200501220837.j0M8bgk22582@mailout.despammed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501220837.j0M8bgk22582@mailout.despammed.com>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously ndiamond@despammed.com wrote:
> Wichert Akkerman wrote:
> 
> > After cleaning up a bit df suddenly showed interesting results:
> > 
> > Filesystem            Size  Used Avail Use% Mounted on
> > /dev/md4             1019M  -64Z  1.1G 101% /tmp
> > 
> > Filesystem           1K-blocks      Used Available Use% Mounted on
> > /dev/md4               1043168 -73786976294838127736   1068904 101% /tmp
> 
> It looks like Windows 95's FDISK
> command created the partitions.

There is no way you can see that from the output I gave, and it is also
incorrect.

> The partition boundaries still remain where Windows 95 put them, and
> you have overlapping partitions.

fdisk does not create overlapping partitions.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
