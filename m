Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272265AbTHIF5z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 01:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272266AbTHIF5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 01:57:55 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:57604 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S272265AbTHIF5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 01:57:54 -0400
Date: Sat, 9 Aug 2003 07:57:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Robert Love <rml@tech9.net>
Cc: kai@tp1.ruhr-uni-bochum.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] remove initramfs temp files
Message-ID: <20030809055750.GA1018@mars.ravnborg.org>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	kai@tp1.ruhr-uni-bochum.de, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <1060391292.31499.52.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060391292.31499.52.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 06:08:12PM -0700, Robert Love wrote:
> Hi, Kai.
> 
> 'make distclean' and 'make mrproper' both fail to remove the file
> initramfs_data.S.tmp from the root of the kernel build tree.

Bitkeeper generated this file during a merge - dunno wht.
So the file was part of the kernel src - but Linus already noticed and
deleted it from the kernel src.
It is gone in test3.

	Sam
