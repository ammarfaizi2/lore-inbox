Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWGLEOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWGLEOQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 00:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWGLEOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 00:14:16 -0400
Received: from main.gmane.org ([80.91.229.2]:64656 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932405AbWGLEOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 00:14:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ask List <askthelist@gmail.com>
Subject: Re: Runnable threads on run queue
Date: Wed, 12 Jul 2006 04:14:05 +0000 (UTC)
Message-ID: <loom.20060712T060407-876@post.gmane.org>
References: <loom.20060708T220409-206@post.gmane.org> <1152429626.9711.34.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.237.13.5 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.4) Gecko/20060508 Firefox/1.5.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault <at> gmx.de> writes:
...
> Looking at the interrupts column, I suspect you have a network problem,
> not a scheduler problem.  Looks to me like your SpamAssasins are simply
> running out of work to do because your network traffic comes in bursts.
> 
> 	-Mike
> 
> 

Network Problem? So your saying our mail servers are not sending spam traffic
fast enough if spam assassin processes are running out of work to do? So when
our mail servers are not sending spam traffic we see our cpu,cs,interrupts, &
runnable threads drop ...?

I'd really like to believe this is true, however in the sa logs there are still
plenty of B (busy threads)...

