Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVAYAJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVAYAJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVAYAGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:06:45 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:4334 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S261742AbVAYADl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:03:41 -0500
Date: Tue, 25 Jan 2005 01:03:39 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: fuse patch needs new libs
Message-ID: <20050125000339.GA610@speedy.student.utwente.nl>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> fuse-transfer-readdir-data-through-device.patch
>   fuse: transfer readdir data through device
It is great that this is fixed, don't remove it, but it does require the fuse
libs to be updated at the same time, or opening dirs for listings will break
like this:

open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ENOSYS (Function
not implemented)

As I personally like for my ls to keep on working, and I assume others will,
too, I would appreciate it if you could add a warning to your announcements the
following one or two weeks or so, so that people can remove this patch if they
don't want to update their libs.

Thank you.

    Sytse
