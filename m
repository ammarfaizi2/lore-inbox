Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265457AbTFMR7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265469AbTFMR7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:59:00 -0400
Received: from windsormachine.com ([206.48.122.28]:46346 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S265457AbTFMR6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:58:06 -0400
Date: Fri, 13 Jun 2003 14:11:52 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 3ware and two drive hardware raid1
In-Reply-To: <3570.66.75.244.69.1055521381.squirrel@www.greenhydrant.com>
Message-ID: <Pine.LNX.4.33.0306131409420.32584-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, David Rees wrote:

> On the 3ware boxes I use, I setup the 3DM utility to run weekly scans of
> the unit to look for badblocks, do you do the same thing?  I've had the
> scan turn up bad disks before.

Too much bloat in the 3dm utility, I use the tw_cli util.

I'm on-site right now, and it turns out it's a double drive failure.

One drive is dead to the point of not even being detected, and the other
is damaged enough that powermax was having difficulty running.

Fortunately the systefiles are completely intact, and it's just a matter
of seeing what backup files are damaged and working around them.

I'll be taking it up with 3ware about why their utility falsely
reported/didn't report the drive failures, according to it the second
drive was just fine.

Mike

