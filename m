Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265463AbUFXPFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUFXPFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUFXPFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:05:30 -0400
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:64524 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S265455AbUFXPEs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:04:48 -0400
Date: Thu, 24 Jun 2004 17:04:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.local
To: Jari Ruusu <jariruusu@users.sourceforge.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2
In-Reply-To: <40DAD511.A19CEFB7@users.sourceforge.net>
Message-ID: <Pine.LNX.4.58.0406241701460.10292@scrub.local>
References: <20040624014655.5d2a4bfb.akpm@osdl.org> <40DAD511.A19CEFB7@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 24 Jun 2004, Jari Ruusu wrote:

> This breaks existing recommended syntax for external modules, because the
> mini Makefile in object directory always provides O= even in cases where
> calling code specified its own object directory:
> 
>     make -C /lib/modules/`uname -r`/build modules M=`pwd` O=/foo

Where is this recommended? How do you know that "/foo" is better directory 
on a random system?

bye, Roman
