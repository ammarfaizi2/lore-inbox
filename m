Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTDNOYy (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 10:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTDNOYx (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 10:24:53 -0400
Received: from franka.aracnet.com ([216.99.193.44]:59339 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263299AbTDNOYx (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 10:24:53 -0400
Date: Mon, 14 Apr 2003 07:36:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bryan Shumsky <bzs@via.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory mapped files question
Message-ID: <8180000.1050330998@[10.10.2.4]>
In-Reply-To: <002101c30239$fc0ae630$fe64a8c0@webserver>
References: <002101c30239$fc0ae630$fe64a8c0@webserver>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, everyone.  I'm running into a problem that I hope someone else has seen,
> and maybe can help solve.  We're using the mmap system function for memory
> mapped files, but our updates never get flushed until we munmap or msysnc.
> Are we missing something?  Is there a tunable parameter in the kernel or
> filing system that can be set to flag these updates as 'write required'?

This was discussed about a week ago on either linux-kernel or linux-mm.
The short answer is "yes, that's deliberate", but an archive search would 
probably be fruitful.

M.

