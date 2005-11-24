Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbVKXShc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbVKXShc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 13:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVKXShc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 13:37:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932642AbVKXShb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 13:37:31 -0500
Date: Thu, 24 Nov 2005 10:37:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ed Tomlinson <tomlins@cam.org>
cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc2
In-Reply-To: <200511240737.59153.tomlins@cam.org>
Message-ID: <Pine.LNX.4.64.0511241020050.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511240737.59153.tomlins@cam.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Nov 2005, Ed Tomlinson wrote:
> 
> What is happening?

The http transport isn't very good for git, so git adds various special 
files to make it work at all. They need to be specially updated, and I 
hadn't done that.

Using the native git protocol through git://git.kernel.org/.. gets around 
it, as does using rsync. 

I just repacked and updated it now, so how http should work too, although 
inefficiently (because it will get a whole new pack - just one of the 
disadvantages of the non-native protocols).

		Linus
