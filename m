Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263525AbTDTEzl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 00:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTDTEzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 00:55:41 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:57271 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263525AbTDTEzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 00:55:40 -0400
Date: Sun, 20 Apr 2003 00:57:22 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.68
Message-ID: <20030420045722.GI2528@phunnypharm.org>
References: <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh, and the devfs stuff by Christoph means that devfs users should beware:  
> in particular, devfs users need to mount the pts filesystem like everybody 
> else does, that duplication got killed.

Not just mount, but you need to build devpts explicitly now too. Before
you could get away with not selecting devpts as an option.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
