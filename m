Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbUC2Eym (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 23:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbUC2Eym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 23:54:42 -0500
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:10157 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S262632AbUC2Eyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 23:54:40 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: lml@beonline.com.au
Subject: Re: Kernel / Userspace Data Transfer   
Date: Mon, 29 Mar 2004 14:57:10 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403291457.10653.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lml@beonline.com.au wrote: 
 > I have a set of counters in a Kernel module that i want to export to a 
 > userspace application. I originally decided to use a /proc entry and parse 
 > the output whenever the userspace application needed this data, however, 
 > i need more than the 4096 that is allowed in /proc and i'm not too keen 
 > on parsing large chunks of text anyway. 
 > 
 > What i would like to do is copy these slabs of text from the kernel to my 
 > userspace application (whenever the application requests it). I've seen the 
 > 'copy_to_user' function and it looks usefull, but have no idea where to start 
 > or how to use it :-/ 
 > 
 > Can someone provide and example or point me in the right direction? Or is there 
 > a better place to ask this question? 
 
Here is a good starter on-line reference
http://www.faqs.org/docs/kernel/
Relevant page
http://www.faqs.org/docs/kernel/x848.html
or as pdf
http://www.tldp.org/LDP/lkmpg/lkmpg.pdf

There is also mbuff that maps shared memory between kernel and user space.
It is pretty easy to use.
http://sourceforge.net/projects/mbuff/

Regards
Ross.
