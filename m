Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUARXZp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 18:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbUARXZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 18:25:45 -0500
Received: from tristate.vision.ee ([194.204.30.144]:60869 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S264283AbUARXZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 18:25:44 -0500
From: Lenar =?ISO-8859-1?Q?L=F5hmus?= <lenar@city.ee>
Subject: Re: Overlapping MTRRs in 2.6.1
To: linux-kernel@vger.kernel.org
Date: Mon, 19 Jan 2004 01:25:39 +0200
References: <1fsuY-4YG-9@gated-at.bofh.it>
User-Agent: KNode/0.7.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20040118232539.AB9B71A0C@xs.dev>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Reich wrote:

> I checked the archives and no one has posted a message on MTRR overlaps
> since
> 2002.  At that time, Andrew Rodland wrote something about what appears to
> be this exact problem; a link to it is

Haven't bothered. But I'm getting those errors and the inability to set up
MTRR's by X too.

I've got a hunch that in my case it depends on how big MTRR vesafb driver 
sets up for itself during boot ... if it's the same size X later asks then
everything is ok.

Usually it's 16MB for vesafb in my machine and 32MB for X. So i've always
just disabled the MTRR set up by vesafb (echo "disable=n" > /proc/mtrr) and
restart X before playing games. This way no problem.

lenar

