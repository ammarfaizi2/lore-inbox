Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263289AbUCXLZh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 06:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbUCXLZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 06:25:37 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:31157 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263289AbUCXLZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 06:25:36 -0500
Date: Wed, 24 Mar 2004 05:54:57 -0500
From: Ben Collins <bcollins@debian.org>
To: Johan FISCHER <linux@fischaz.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Panic] ieee1394 HD when moving files
Message-ID: <20040324105457.GZ2255@phunnypharm.org>
References: <20040324195300.1q8sc0gcckooc4os@webmail.fischaz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324195300.1q8sc0gcckooc4os@webmail.fischaz.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 07:53:00PM +1100, Johan FISCHER wrote:
> 
> When moving a file >300Mo to my external Hard drive (connected to the ieee1394
> port), The kernel sytematically panic and crashed with the same error.
> 
> The problem seems to come from the DMA part of the OHCI1394 driver and affect
> the kernel above version 2.6.2 (i'll try the 2.6.3 if I have some times but I'm
> almost sure the 2.6.2 is the last version to work).

This is fixed if you use 2.6.5-rc2 + our SVN repo.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
