Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbUL2LW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbUL2LW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 06:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUL2LW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 06:22:56 -0500
Received: from danga.com ([66.150.15.140]:13473 "EHLO danga.com")
	by vger.kernel.org with ESMTP id S261334AbUL2LWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 06:22:55 -0500
Date: Wed, 29 Dec 2004 03:22:53 -0800 (PST)
From: Brad Fitzpatrick <brad@danga.com>
X-X-Sender: bradfitz@danga.com
To: Michael Tewner <tewner@jct.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux SMT question
In-Reply-To: <41D289A6.7050805@jct.ac.il>
Message-ID: <Pine.LNX.4.58.0412290319180.17218@danga.com>
References: <41D289A6.7050805@jct.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

On Wed, 29 Dec 2004, Michael Tewner wrote:

> I'm sorry if this has been covered before. If it has, please direct me
> on where to look.
>
> Over the year, our university started acquiring dual Xeon servers. I
> havn't been able to find consistent information regarding how linux
> deals with the SMT (HT?).

Check out this article:
http://lwn.net/Articles/80911/

lwn.net's a great source of both news and timely explanations of kernel
changes underway.

> Finally, is there a way to force an application to run an separate
> physical CPU's? Perhaps a MOSIX-like /proc interface (where each PID has
> a special file with preferences such as keep-local)?

$ man 2 sched_setaffinity

- Brad
