Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVLZW1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVLZW1a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVLZW1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:27:15 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:28064 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750804AbVLZW1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:27:13 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 09/36] m68k: fix macro syntax to make current binutils happy
Date: Mon, 26 Dec 2005 22:59:18 +0100
User-Agent: KMail/1.8.2
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1EpIOj-0004qc-HA@ZenIV.linux.org.uk>
In-Reply-To: <E1EpIOj-0004qc-HA@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512262259.19230.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 22 December 2005 05:49, Al Viro wrote:

> recent as(1) doesn't think that . terminates a macro name, so
> getuser.l is _not_ treated as invoking getuser with .l as the
> first argument.

Could you please hold back with the binutils changes? Eventually this should 
rather be fixed in gas or they have to properly document the expected 
behaviour, so it doesn't break the next time they change it.

bye, Roman
