Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTEYDpC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 23:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTEYDpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 23:45:02 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:59796 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261308AbTEYDpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 23:45:01 -0400
Date: Sat, 24 May 2003 23:10:00 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030525031000.GJ504@phunnypharm.org>
References: <20030525000701.GG504@phunnypharm.org> <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> which is what pretty much everybody really _wants_ to have anyway? We 
> should deprecate "strncpy()" within the kernel entirely.

Amen.

If you could atleast apply the KOBJ_NAME_LEN part of the patch, I'll
start doing a much wider scope patch of replacing strncpy in the whole
kernel.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
