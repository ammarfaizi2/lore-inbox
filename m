Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288420AbSBMSpZ>; Wed, 13 Feb 2002 13:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288566AbSBMSpW>; Wed, 13 Feb 2002 13:45:22 -0500
Received: from air-2.osdl.org ([65.201.151.6]:530 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S288420AbSBMSpN>;
	Wed, 13 Feb 2002 13:45:13 -0500
Date: Wed, 13 Feb 2002 10:40:55 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: <Pine.LNX.4.33L2.0202130857320.1530-200000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33L2.0202131038320.1530-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Randy.Dunlap wrote:

| On Wed, 13 Feb 2002, Richard B. Johnson wrote:
|
| | On Wed, 13 Feb 2002, Horst von Brand wrote:
| |
| | > Daniel Phillips <phillips@bonn-fries.net> said:
| | > > On February 12, 2002 05:38 pm, Bill Davidsen wrote:
| | >
| | > [...]
| | [SNIPPED...]
| |
| | My idea is to take the .config file and remove most of its
| | redundancy and unnecessary verbage. Then, the result is
| | compressed and written to a constant global array, linked
| | into the kernel. Both the array and the array length will then
| | be available from /proc/kcore for user-mode tools to recreate the
| | .config file.
|
| This is a bit similar to what I did last weekend (and attach
| here).  Mine goes into the kernel boot file, however, so that
| it can be read even when the kernel isn't running.
|
| I'll experiment with ideas from Andreas (thanks) or Ian Soboroff
| to create a userspace get-config tool.
|
| One small nit:  you say "user-mode tools", but /proc/kcore
| is read-only for root only -- right?
| That's not desirable or required IMO.


| On Wed, 13 Feb 2002, Richard B. Johnson wrote:
> Hmmm. You are going to make a kernel and don't have root-access to
> create a kernel configuration file?

Well, I did say "small nit".  But some of us prefer to run
as root as little as possible, and building a kernel
certainly doesn't require root privileges.
Only installing it does (or may).

~Randy

