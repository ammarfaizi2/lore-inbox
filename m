Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbUCIKwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 05:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUCIKwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 05:52:35 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:31438 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261860AbUCIKw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 05:52:29 -0500
Message-ID: <404DA1E6.9070701@stesmi.com>
Date: Tue, 09 Mar 2004 11:52:22 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jinu M." <jinum@esntechnologies.co.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: disable partitioning!
References: <1118873EE1755348B4812EA29C55A9721287C8@esnmail.esntechnologies.co.in>
In-Reply-To: <1118873EE1755348B4812EA29C55A9721287C8@esnmail.esntechnologies.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jinu.

> We are writing a block device driver for 2.4.x kernel.
> I want to know how to indicate to the filesystem that our block driver does not support partitions.
> I mean fdisk should not be allowed on disks supported by our block driver.

You can run fdisk on a file if you want to, it doesn't care what type of
block device it is. What you're really asking for is a way to make the
kernel not read the partition table if it exists on the device and
that's something else.

That is also something that the filesystem doesn't handle. Filesystems
are systems that handle files (heh).

// Stefan
