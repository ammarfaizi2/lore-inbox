Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTE2Fp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 01:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTE2Fo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 01:44:28 -0400
Received: from ip68-111-188-90.sd.sd.cox.net ([68.111.188.90]:6788 "EHLO
	rei.moonkingdom.net") by vger.kernel.org with ESMTP id S261917AbTE2FoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 01:44:18 -0400
Date: Wed, 28 May 2003 22:57:35 -0700
From: Marc Wilson <msw@cox.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc6
Message-ID: <20030529055735.GB1566@moonkingdom.net>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20030529052425.GA1566@moonkingdom.net> <BKEGKPICNAKILKJKMHCAIEANECAA.Riley@Williams.Name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEGKPICNAKILKJKMHCAIEANECAA.Riley@Williams.Name>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 06:34:48AM +0100, Riley Williams wrote:
> The basic problem there is that any mail client needs to know
> just how many messages are in a particular folder to handle that
> folder, and the only way to do this is to count them all. That's
> what takes the time when one opens a large folder.

No, the basic problem there is that the kernel is deadlocking.  Read the
VERY long thread for the details.

I think I have enough on the ball to be able to tell the difference between
mutt opening a folder and counting messages, with a counter and percentage
indicator advancing, and mutt sitting there deadlocked with the HD activity
light stuck on and all the rest of X stuck tight.

And it just happened again, so -rc6 is no sure fix.  What did y'all that
reported the problem had gone away do, patch -rc4 with the akpm patches?
^_^

-- 
 Marc Wilson |     Fortune favors the lucky.
 msw@cox.net |
