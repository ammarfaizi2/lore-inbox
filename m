Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTKILY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 06:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTKILY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 06:24:58 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:40711 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262356AbTKILY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 06:24:57 -0500
Date: Sun, 9 Nov 2003 14:24:35 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Bob McElrath <bob+linux-kernel@mcelrath.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/rtc on alpha
Message-ID: <20031109142435.A4596@jurassic.park.msu.ru>
References: <20031108213356.GD16295@mcelrath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031108213356.GD16295@mcelrath.org>; from bob+linux-kernel@mcelrath.org on Sat, Nov 08, 2003 at 01:33:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08, 2003 at 01:33:57PM -0800, Bob McElrath wrote:
> Why is the alpha kernel code grabbing the rtc interrupt?  Is it possible
> it share its use with a user program?  Would reprogramming the interrupt
> rate by a user program do violence to some internel kernel timing?

On most Alphas RTC is the system timer (running at 1024 Hz).
So changing the interrupt rate from user space wouldn't be a good idea.

Ivan.
