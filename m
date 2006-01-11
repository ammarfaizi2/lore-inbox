Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWAKTLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWAKTLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWAKTLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:11:18 -0500
Received: from mta01.mail.tds.net ([216.170.230.81]:949 "EHLO
	mta01.mail.tds.net") by vger.kernel.org with ESMTP id S1751158AbWAKTLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:11:17 -0500
Date: Wed, 11 Jan 2006 13:10:58 -0600 (CST)
From: David Lloyd <dmlloyd@tds.net>
To: Kenny Simpson <theonetruekenny@yahoo.com>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is user-space AIO dead?
In-Reply-To: <20060111184532.42618.qmail@web34112.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.64.0601111304390.14191@tomservo.workpc.tds.net>
References: <20060111184532.42618.qmail@web34112.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, Kenny Simpson wrote:

> --- David Lloyd <dmlloyd@tds.net> wrote:
>> Wouldn't nonblocking I/O on regular files be nice?
>
> Yes it could be.  As I understand it, regular file writes (not O_DIRECT) 
> are only to the page cache and only block when there is memory pressure 
> (so it is more of a throttle).

If you were however using O_DIRECT or O_SYNC, you would then have a 
mechanism to know when your writes have made it to disk, which might be 
useful for transactional systems.

- D
