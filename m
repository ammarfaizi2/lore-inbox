Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbTCZKkZ>; Wed, 26 Mar 2003 05:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261598AbTCZKkY>; Wed, 26 Mar 2003 05:40:24 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:25790 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S261567AbTCZKkX>; Wed, 26 Mar 2003 05:40:23 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: Preferred way to load non-free firmware
Date: Wed, 26 Mar 2003 10:51:32 +0000 (UTC)
Message-ID: <slrnb831hh.1hh.usenet@bender.home.hensema.net>
References: <Pine.LNX.4.50.0303252007420.6656-100000@marabou.research.att.com>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin (proski@gnu.org) wrote:
> 7) Encode the firmware into a header file, add it to the driver and
> pretend that the copyright issue doesn't exist (like it's done in the
> Keyspan USB driver).

It doesn't exist. At lost, not on the part of Linux. The license of the
firmware may prohibit it.

The way I interpret the GPL you may link _any_ _data_ into a GPL'ed
program. Since this firmware is _data_ from the point of view of the kernel
(eg. the stream of execution never enters the firmware and it isn't mapped
to a text segment) there shouldn't be any problem.

It may still be preferable to choose another option, but linking the
firmware into a module has the advantage of the user being able to do
module autoloading without further configuration (eg. post-install lines in
modules.conf).

-- 
Erik Hensema <erik@hensema.net>
