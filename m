Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbUBZStM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUBZStM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:49:12 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:59856 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262825AbUBZStL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:49:11 -0500
Date: Thu, 26 Feb 2004 13:48:45 -0500
From: Ben Collins <bcollins@debian.org>
To: Jim Deas <jdeas0648@jadsystems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel disables interrupts
Message-ID: <20040226184845.GA5599@phunnypharm.org>
References: <200402261025.AA3240886544@jadsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402261025.AA3240886544@jadsystems.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 10:25:02AM -0800, Jim Deas wrote:
> I am trouble shooting a new driver and have found a new
> kernel item that makes trouble shooting a bit harder.
> When I unload my test driver and before I can reload it
> (reseting the interrut controls)the Kernerl disables
> the chattering interrupt.
> Once the kernel has disable a spurious interrupt is there
> a way to get it back?

Shouldn't your driver just disable the interrupt before unloading?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
