Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264333AbTKZUmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTKZUmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:42:40 -0500
Received: from windsormachine.com ([206.48.122.28]:51648 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S264340AbTKZUlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:41:08 -0500
Date: Wed, 26 Nov 2003 15:41:05 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 not cat proof
In-Reply-To: <20031126201052.GA16106@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.56.0311261533310.489@router.windsormachine.com>
References: <20031126201052.GA16106@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003, bert hubert wrote:

> This bug has been seen here over eight years ago and it is back.. linux
> 2.6.0-test4 is still not cat proof :-)

There has been a fix for this issue in the kernel source for quite awhile.

>From as far back as the configuration utility in 2.4.22:

CONFIG_WATCHDOG:

 If you say Y here (and to one of the following options) and create a
 character special file /dev/watchdog with major number 10 and minor
 number 130 using mknod ("man mknod"), you will get a watchdog, i.e.:


It should be under Character devices somewhere.

Hope this helps,

Mike
