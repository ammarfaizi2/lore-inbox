Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWDBI6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWDBI6w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 04:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWDBI6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 04:58:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:30375 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932294AbWDBI6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 04:58:52 -0400
Date: Sun, 2 Apr 2006 10:58:50 +0200
From: Olaf Hering <olh@suse.de>
To: John Mylchreest <johnm@gentoo.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060402085850.GA28857@suse.de>
References: <20060401224849.GH16917@getafix.willow.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060401224849.GH16917@getafix.willow.local>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Apr 01, John Mylchreest wrote:

> Since ppc32 has been made to use arch/powerpc it has introduced a build-time
> regression where userland CFLAGS are being leaked. This is especially obvious
> when a user tries to "make zImage" with an SSP enabled gcc.

What build error do you get?
