Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWFYBT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWFYBT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 21:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWFYBT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 21:19:28 -0400
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:62315 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S932432AbWFYBT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 21:19:28 -0400
Subject: Re: Kernelsources writeable for everyone?!
From: Mark Rosenstand <mark@borkware.net>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Daniel <damage@rooties.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060624181702.GG27946@ftp.linux.org.uk>
References: <200606242000.51024.damage@rooties.de>
	 <20060624181702.GG27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Sun, 25 Jun 2006 03:20:52 +0200
Message-Id: <1151198452.6508.10.camel@mjollnir>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 19:17 +0100, Al Viro wrote:
> On Sat, Jun 24, 2006 at 08:00:50PM +0200, Daniel wrote:
> > Hi,
> > may be this was reported/asked 999999999 times, but here ist the 1000000000th:
> > 
> > I have downloaded linux-2.6.17.1 10 min ago and I noticed that every file is 
> > writeable by everyone. What's going on there?

It's an abusive way of telling people to not extract the kernel sources
as root. Surely if they don't follow the recommended workflow, their box
deserve to be rooted.

> You are unpacking tarballs as root and preserve ownership and permissions.
> Don't.

Preserving ownership and permissions is the default behaviour for GNU
tar when running as root. Other implementations require the -p option.

