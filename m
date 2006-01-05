Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751869AbWAEDOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbWAEDOI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWAEDOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:14:07 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:55491 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751869AbWAEDOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:14:06 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 08/41] m68k: fix macro syntax to make current binutils happy
Date: Thu, 5 Jan 2006 04:11:35 +0100
User-Agent: KMail/1.8.2
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
References: <E1EtvYX-0003Lo-Gf@ZenIV.linux.org.uk>
In-Reply-To: <E1EtvYX-0003Lo-Gf@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601050412.16136.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 04 January 2006 00:27, Al Viro wrote:

> recent as(1) doesn't think that . terminates a macro name, so
> getuser.l is _not_ treated as invoking getuser with .l as the
> first argument.

Al, please don't send the binutils patches yet, I simply need more time to 
figure out how to deal with it and it's not a critical patch.
Linus, please don't apply patch 8 and 9.

bye, Roman
