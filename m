Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRDFEwi>; Fri, 6 Apr 2001 00:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRDFEw2>; Fri, 6 Apr 2001 00:52:28 -0400
Received: from cs.columbia.edu ([128.59.16.20]:56564 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S131246AbRDFEwV>;
	Fri, 6 Apr 2001 00:52:21 -0400
Date: Thu, 5 Apr 2001 21:51:39 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Andrew Daviel <advax@triumf.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: syslog insmod please!
In-Reply-To: <200104060442.f364g4A27761@webber.adilger.int>
Message-ID: <Pine.LNX.4.30.0104052147060.14947-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001, Andreas Dilger wrote:

> Why do it from user space?  Simply add a printk() to sys_init_module() or
> similar.  

Agreed, but at that point the solution has absolutely nothing to do with 
insmod anymore. :-)

Besides, as you said, I don't really see the point. It certainly doesn't 
help with logging the actions of an attacker, and on the other hand kmod 
already logs its own actions.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

