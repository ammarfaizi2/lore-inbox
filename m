Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTEWSYY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 14:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbTEWSYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 14:24:24 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:64223 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S264127AbTEWSYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 14:24:23 -0400
Date: Fri, 23 May 2003 14:34:58 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: kernel <kernel@crazytrain.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap - a schema proposal
In-Reply-To: <1053714233.3759.62.camel@thong>
Message-ID: <Pine.LNX.4.33.0305231428000.13942-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 23 May 2003, kernel wrote:

> Hello Ahmed
>
> question for you.  What about what Microsoft is purportedly doing for
> 2003 Server?  Wherein they use the public key model.  I.E., the
> pagefile.sys entire file is encrypted with public key and that exchange
> happens with a user or users who are then allowed to use it as needed.

Well this is currently achievable without doing any further work in its
most trivial form by using crypto loop devices.  The idea is to hide the
entire functionality from the users. Nothing that the user is doing should
change.

The model i proposed is designed under two main constraints:

1. User should be oblivious to any changes to the system.
2. We don't want to redesign the linux mm subsystem we just want to become
friends with it. ;)

Cheers,

Ahmed.

