Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbTJXUZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 16:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTJXUZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 16:25:17 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:45528 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262594AbTJXUZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 16:25:12 -0400
Subject: Re: mem size at bootup
From: Dave Hansen <haveblue@us.ibm.com>
To: Yaoping Ruan <yruan@cs.princeton.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F99849D.7CA61D63@cs.princeton.edu>
References: <3F99849D.7CA61D63@cs.princeton.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1067027106.869.11.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Oct 2003 13:25:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-24 at 12:59, Yaoping Ruan wrote:
> could anybody tell me if there's any option to specify the size of
> memory I want to use in Linux. We have a box with 4GB memory but we
> would like to run some experiment with only 2GB memory. Is there any
> option like the "hw.physmem" in FreeBSD?

mem= on the kernel command-line.

In lilo, you do something like this:
image=/boot/vmlinuz-2.4.20
	label=2420
	read-only
	optional
	append="mem=2G"

-- 
Dave Hansen
haveblue@us.ibm.com

