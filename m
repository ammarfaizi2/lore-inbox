Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTHaPrM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbTHaPqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:46:18 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:24962
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262342AbTHaPo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:44:58 -0400
Date: Sun, 31 Aug 2003 11:44:32 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Thomas Molina <tmolina@cablespeed.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test4-mm4
In-Reply-To: <Pine.LNX.4.44.0308310926120.26483-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0308311142550.16584@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0308310926120.26483-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Aug 2003, Thomas Molina wrote:

> Thank you Adrew.  I have been following a panic in store_stackinfo since 
> it was introduced with CONFIG_DEBUG_PAGEALLOC (see bugzilla #973).  
> 2.6.0-test4-mm4 was the first kernel version I have tested which didn't 
> exhibit this failure mode.  
> 
> I do get a hang on boot in RedHat 8 if all the other "kernel hacking" 
> options are enabled.  This hang comes at the point in the boot sequence 
> where the next message I would expect is the mounting of /proc.  I've not 
> looked into it too deeply since it sounded similar to what others have 
> seen, and it wasn't my main focus.  I'll go back later and look into it if 
> the condition persists.

Well you appeared to have serio problems and there have been a number of 
changes in the input department. Do you know which kernel hacking option 
causes the new hang?
