Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbUBWNXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbUBWNXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:23:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59574 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261844AbUBWNXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:23:12 -0500
Date: Thu, 19 Feb 2004 16:14:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040219151441.GD467@openzaurus.ucw.cz>
References: <pan.2004.02.06.18.59.44.936432@smurf.noris.de> <92VRVYaHw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92VRVYaHw-B@khms.westfalen.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> POSIX says on <http://www.opengroup.org/onlinepubs/007904975/functions/ 
> read.html>:
> 
> [...]
> DESCRIPTION
> 
> The read() function shall attempt to read nbyte bytes from the file
> associated with the open file descriptor, fildes, into the buffer pointed
> to by buf. The behavior of multiple concurrent reads on the same pipe,
> FIFO, or terminal device is unspecified.

...which implies that concurrent reads on regular files are okay :-P.

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

