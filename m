Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932258AbWFDVVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWFDVVs (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWFDVVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:21:48 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:13786 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S932258AbWFDVVr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:21:47 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.18 hdrinstall (Re: 2.6.18 -mm merge plans)
Date: Sun, 4 Jun 2006 23:20:09 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060604135011.decdc7c9.akpm@osdl.org>
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606042320.09341.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 4. June 2006 22:50, Andrew Morton wrote:
> git-hdrcleanup.patch
> git-hdrinstall.patch
>
>  This is Dave Woodhouse's work cleaning up the kernel headers and adding a
>  `make headerinstall' target which automates the exporting of kernel
>  headers as a userspace-usable package.
>
>  All I can say about this is that it doesn't appear to break anything and
>  is ready to merge from that point of view.  It's not an area in which I
>  have much interest or knowledge.

I've played with it and rebuilt all of Ark Linux (around 5000 packages) with 
glibc-kernheaders replaced with make headerinstall-ed headers, no problems at 
all (except some stupid apps thinking BITS_PER_LONG is supposed to be 
defined, but they were probably broken with the last couple of 
glibc-kernheaders releases as well).

So from a user's perspective, it's ready.
