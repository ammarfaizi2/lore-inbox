Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283245AbRLCXqT>; Mon, 3 Dec 2001 18:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282165AbRLCXjA>; Mon, 3 Dec 2001 18:39:00 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:62461 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S284940AbRLCSmN>; Mon, 3 Dec 2001 13:42:13 -0500
Date: Mon, 3 Dec 2001 13:42:12 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: <mingo@devserv.devel.redhat.com>
To: Brian McEntire <brianm@fsg1.nws.noaa.gov>
cc: <linux-kernel@vger.kernel.org>, <systems@clifford.nws.noaa.gov>
Subject: Re: PROBLEM: system hangs on dual 1GHz PIII system with 2.4.13-ac8
In-Reply-To: <Pine.LNX.4.33.0112031336100.25875-100000@fsg1.nws.noaa.gov>
Message-ID: <Pine.LNX.4.33.0112031340220.28071-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Dec 2001, Brian McEntire wrote:

> I can't boot kernels except for -ac patched kernels (because I have
> ext3 file systems that I converted during the 7.1 -> 7.2 upgrade.)

the 2.4.16 kernel includes ext3fs support, so you can try 2.4.17-pre2 as 
well.

> Where can I get the 2.4.17-2 kernel or RPM?

the patch is in Marcelo's directory:

 http://www.kernel.org/pub/linux/kernel/people/marcelo/2.4/testing/patch-2.4.17-pre2.bz2

apply it to a vanilla 2.4.16 tree.

	Ingo

