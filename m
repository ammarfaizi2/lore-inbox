Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbUKFHjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbUKFHjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 02:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUKFHjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 02:39:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:260 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261334AbUKFHjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 02:39:03 -0500
Date: Sat, 6 Nov 2004 08:39:01 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Camilo A. Reyes" <camilo@leamonde.no-ip.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Console 80x50 SVGA
Message-ID: <20041106073901.GA783@alpha.home.local>
References: <20041105224206.GA16741@leamonde.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105224206.GA16741@leamonde.no-ip.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 05, 2004 at 04:42:06PM -0600, Camilo A. Reyes wrote:
> Just a question about displaying the console in 80x50 lines instead of
> 80x30. I have enabled frame buffer but as of now its doing only 80x30.

You need to change the mode at boot (vga=XXX). I'm in 128x48 for example
because my frame buffer is 1024x768 and my font is 8x16. You can also
change your font size. 80x50 is doable with a 8x8 font in 640x400, but it
is not really readable.

Cheers,
Willy

