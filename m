Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWJGXzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWJGXzS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 19:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWJGXzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 19:55:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35995 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932521AbWJGXzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 19:55:17 -0400
From: Roman Zippel <zippel@linux-m68k.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Date: Sun, 8 Oct 2006 01:50:39 +0200
User-Agent: KMail/1.9.4
Cc: torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610080150.41268.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 06 October 2006 15:34, David Howells wrote:

> +config ARCH_HAS_ILOG2_U32
> +	bool
> +	default n

This actually doesn't do much, so you only have to add it, where it's 'y' 
and "def_bool y" is shorter there.

bye, Roman
