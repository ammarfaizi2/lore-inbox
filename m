Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWJAPkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWJAPkY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 11:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWJAPkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 11:40:24 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:32795 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751193AbWJAPkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 11:40:23 -0400
Subject: Re: Announce: gcc bogus warning repository
From: Daniel Walker <dwalker@mvista.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <451FC657.6090603@garzik.org>
References: <451FC657.6090603@garzik.org>
Content-Type: text/plain
Date: Sun, 01 Oct 2006 08:40:13 -0700
Message-Id: <1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 09:44 -0400, Jeff Garzik wrote:
> The level of warnings in a kernel build has lately increased to the 
> point where it is hiding bugs and otherwise making life difficult.
> 
> In particular, recent gcc versions throw warnings when it thinks a 
> variable "MAY be used uninitialized", which is not terribly helpful due 
> to the fact that most of these warnings are bogus.
> 
> For those that may find this valuable, I have started a git repo that 
> silences these bogus warnings, after careful auditing of code paths to 
> ensure that the warning truly is bogus.
> 
> The results may be found in the "gccbug" branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git
> 

Steven Rostedt an I worked on this problem in May. Steven came up with,
a nice way to handle these warnings, which doesn't increase code size.
Here's the post if your interested.

http://lkml.org/lkml/2006/5/11/50

Daniel

