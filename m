Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVKEEqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVKEEqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 23:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVKEEqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 23:46:14 -0500
Received: from outbound05.telus.net ([199.185.220.224]:55687 "EHLO
	priv-edtnes40.telusplanet.net") by vger.kernel.org with ESMTP
	id S1751160AbVKEEqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 23:46:14 -0500
From: Andi Kleen <ak@suse.de>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Balancing near the locking cliff, with some numbers
Date: Sat, 5 Nov 2005 05:46:07 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
References: <200511042056.59813.ak@suse.de> <20051105031218.GK7992@ftp.linux.org.uk>
In-Reply-To: <20051105031218.GK7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511050546.07944.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 November 2005 04:12, Al Viro wrote:
> On Fri, Nov 04, 2005 at 08:56:59PM +0100, Andi Kleen wrote:
> > open:
> > locks: 106 sems: 32 atomics: 50 rwlocks: 30 irqsaves: 89 barriers: 47
>
> How long was the pathname and how much of that was in cache?

It read random files from /usr/X11R6/bin to get something out of cache.
The bin directory was likely all in dcache and the directory lpages in buffer 
cache.

-Andi
