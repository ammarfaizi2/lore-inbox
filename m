Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVEROVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVEROVS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVEROTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:19:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14749 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262210AbVEROTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:19:05 -0400
Date: Wed, 18 May 2005 15:19:26 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Delay loop cleanups
Message-ID: <20050518141925.GF29811@parcelfarce.linux.theplanet.co.uk>
References: <200505180420.j4I4KQ6H017322@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505180420.j4I4KQ6H017322@ccure.user-mode-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 12:20:26AM -0400, Jeff Dike wrote:
> This patch cleans up the delay implementations a bit, makes the loops
> unoptimizable, and exports __udelay and __const_udelay.

	If you do exports in i386 delay.c, remove them from
arch/um/sys-i386/ksyms.c...
