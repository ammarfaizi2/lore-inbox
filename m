Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWFOLrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWFOLrT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWFOLrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:47:19 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:52714 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030258AbWFOLrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:47:18 -0400
Date: Thu, 15 Jun 2006 13:46:55 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH] m68k: bogus constraints in signal.h
In-Reply-To: <20060615111126.GJ27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0606151343200.17704@scrub.home>
References: <20060615111126.GJ27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jun 2006, Al Viro wrote:

> bfset and friends need "o", not "m" - they don't work with autodecrement
> memory arguments.  bitops.h had it fixed, signal.h hadn't...

I have a better version for this one pending, which I have queued for 
2.6.18.

bye, Roman
