Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTHaNmu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 09:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbTHaNmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 09:42:50 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:34455
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261918AbTHaNmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 09:42:49 -0400
Date: Sun, 31 Aug 2003 09:41:23 -0500 (CDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, <zwane@holomorphy.com>
Subject: Re: 2.6.0-test4-mm4
In-Reply-To: <20030830161536.7e7be6d3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0308310926120.26483-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Adrew.  I have been following a panic in store_stackinfo since 
it was introduced with CONFIG_DEBUG_PAGEALLOC (see bugzilla #973).  
2.6.0-test4-mm4 was the first kernel version I have tested which didn't 
exhibit this failure mode.  

I do get a hang on boot in RedHat 8 if all the other "kernel hacking" 
options are enabled.  This hang comes at the point in the boot sequence 
where the next message I would expect is the mounting of /proc.  I've not 
looked into it too deeply since it sounded similar to what others have 
seen, and it wasn't my main focus.  I'll go back later and look into it if 
the condition persists.

