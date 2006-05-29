Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWE2LLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWE2LLR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 07:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWE2LLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 07:11:17 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42420 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750724AbWE2LLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 07:11:16 -0400
Date: Mon, 29 May 2006 13:11:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Olaf Hering <olh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Paul Mackeras <paulus@samba.org>
Subject: Re: [PATCH] enable CONFIG_KALLSYMS_ALL unconditionally for xmon
 after allnoconfig
In-Reply-To: <20060529093602.GA17819@suse.de>
Message-ID: <Pine.LNX.4.64.0605291308380.17704@scrub.home>
References: <20060528211206.GA13458@suse.de> <20060529093602.GA17819@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 May 2006, Olaf Hering wrote:

> enable CONFIG_KALLSYMS_ALL, because CONFIG_KALLSYMS is not selectable per default
> xmon can not lookup all symbols without CONFIG_KALLSYMS_ALL,
> 'ls log_buf' will not work as example.

Unless xmon is completely unusable without CONFIG_KALLSYMS_ALL, I'd rather 
leave it optional.

bye, Roman
