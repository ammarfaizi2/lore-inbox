Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbUCDOJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 09:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUCDOJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 09:09:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:31874 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261845AbUCDOJk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 09:09:40 -0500
Date: Thu, 4 Mar 2004 09:11:07 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: GPLv2 or not GPLv2? (no license bashing)
In-Reply-To: <200403040838.31412.eike-kernel@sf-tec.de>
Message-ID: <Pine.LNX.4.53.0403040848530.17622@chaos>
References: <200403040838.31412.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, Rolf Eike Beer wrote:

> Hi all,
>
> just digging a bit in the kernel and found some funny things:
>
> -there is a tag only for "GPL v2" but there are some drivers claiming to be
> v2 and not using this (patch will follow)
> -there are some drivers with the comment ", either version 2 of the License."
> in the header. s/either // ? If so, there are some more files where someone
> should change MODULE_LICENSE("GPL") to "GPL v2".

I don't think anybody, but the original author, can change the
licensing or its symbology. In other words, if there is a
MODULE_LICENSE("ZORK"), that stays until it is changed by
the author that inserted it initially.

In fact, a review of Linux history by a first-year law student
may show that somebody, not the original author, added the
MODULE_LICENSE() macro to a lot of modules that didn't have
any such macro, and thereby assigned some license that did
not previously exist! Such an implied license may not be valid
because the original author of the work did not perform that
assignment.

I think you need to be vigilant and not fall into the RMS trap
where anything that is "found" anywhere, automatically becomes
the property of GPL. It will invalidate the original spirit
and nature of GPL and, likely throw all such works into
the public domain. Caution is necessary, especially now
that there is a Wind River-Red Hat connection, and other such
connections being established in the future. Wind River was
the company that "bought" BSD/OS. I don't know how you do that --

Anyway, be very careful about changing what might have been
the original author's intent.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


