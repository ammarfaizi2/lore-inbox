Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265629AbTIJUBR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265634AbTIJUBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:01:17 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:36051 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265629AbTIJUBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:01:06 -0400
Date: Wed, 10 Sep 2003 15:58:02 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: kbuild: Build minimum in scripts/ when changing configuration
In-Reply-To: <20030910191758.GC5604@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.33.0309101555590.13584-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Sam Ravnborg wrote:
>+scripts/fixdep:
>+	$(Q)$(MAKE) $(build)=scripts $@
>+

Umm, that still doesn't address the "already up to date" make will generate
when fixdep doesn't need to be rebuilt. (which is why I changed things the
way I did.)

--Ricky


