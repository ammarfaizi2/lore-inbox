Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbTIJUXi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265757AbTIJUXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:23:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47793 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265755AbTIJUXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:23:36 -0400
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
From: Dave Hansen <haveblue@us.ibm.com>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Cliff White <cliffw@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F5F7604.9040305@austin.ibm.com>
References: <200309092353.h89NrTN31627@mail.osdl.org>
	 <3F5E8897.7040302@cyberone.com.au>  <3F5F7604.9040305@austin.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1063225389.32102.122.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Sep 2003 13:23:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 12:05, Steven Pratt wrote:
>  I gave this a try on the same setup that I am using for the regression 
> tests and the scheduler tests for Andrew.  What I got was the following 
> oops:

If you compile your kernel with debugging (-g) turned on, then you can
use addr2line on the vmlinux and the eip where it crashed.  That is
immensely useful in diagnosing oopses.  Guessing where
load_balance+0x257 is actually located is kinda hard.

-- 
Dave Hansen
haveblue@us.ibm.com

