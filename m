Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUATCQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbUATCQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 21:16:14 -0500
Received: from [24.35.117.106] ([24.35.117.106]:36227 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265161AbUATCNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 21:13:41 -0500
Date: Mon, 19 Jan 2004 21:13:26 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm4
In-Reply-To: <20040119165730.7f250869.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0401192107550.5662@localhost.localdomain>
References: <20040115225948.6b994a48.akpm@osdl.org>
 <Pine.LNX.4.58.0401191912300.5662@localhost.localdomain>
 <20040119165730.7f250869.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Jan 2004, Andrew Morton wrote:

> > Cannot open master raw device '/dev/rawctl' (No such device)
> 
> Do you have
> 
> 	alias char-major-162 raw
> 
> in /etc/modprobe.conf?

I added that and got the same message on the next reboot.  I don't get 
this on the 2.4 RedHat kernel.  I will have to do a bk pull for 2.6 since 
I have been running mm kernels exclusively lately.  
