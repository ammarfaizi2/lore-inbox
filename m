Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTENOQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTENOQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:16:30 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:65211 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S262232AbTENOQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:16:29 -0400
Date: Wed, 14 May 2003 10:27:01 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: walt <wa1ter@myrealbox.com>
Cc: Pau Aliagas <linuxnow@newtral.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: cannot boot 2.5.69
In-Reply-To: <3EC2426D.9060606@myrealbox.com>
Message-ID: <Pine.LNX.4.33.0305141025010.10993-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 May 2003, walt wrote:

> Pau Aliagas wrote:
> > I still find no way to boot a 2.5.69 kernel.
> > It reports: "no console found, specify init= option"

Looks as if init can't seem to find the device node file... Check your
/dev to see if there is a console entry there:

	/dev/console c 5 1

This isn't a kernel issue.

Ahmed.

