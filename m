Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVGUF6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVGUF6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 01:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVGUF6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 01:58:31 -0400
Received: from mx.freeshell.ORG ([192.94.73.21]:29419 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261651AbVGUF6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 01:58:31 -0400
From: Jim Nance <jlnance@sdf.lonestar.org>
Date: Thu, 21 Jul 2005 02:13:53 +0000
To: Antonio Vargas <windenntw@gmail.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       Miquel van Smoorenburg <miquels@cistron.nl>, naber@inl.nl,
       linux-kernel@vger.kernel.org
Subject: Re: a 15 GB file on tmpfs
Message-ID: <20050721021353.GA23309@SDF.LONESTAR.ORG>
References: <200507201416.36155.naber@inl.nl> <20050720132006.GI7050@harddisk-recovery.com> <dbljub$mgm$1@news.cistron.nl> <20050720144421.GK7050@harddisk-recovery.com> <69304d1105072008237dd21e08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69304d1105072008237dd21e08@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2005 at 05:23:52PM +0200, Antonio Vargas wrote:
> Most probably the cost of programming and debugging the hand-made
> paging on 32bit machines will cost more than the difference for a
> 64bit machine.

I'll second that.  There may not even be a price difference.
I've had quotes for otherwise comprable 32 bit Xeon servers
come in more expensive than 64 bit AMD machines.

One piece of advice I would offer is to make sure you buy
good ECC memory.  I've been working with large servers
for the last few years, and trying to be cheap with
memory has caused a lot of hard to track down problems.

- Jim

-- 
jlnance@sdf.lonestar.org
SDF Public Access UNIX System - http://sdf.lonestar.org
