Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUITKXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUITKXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 06:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUITKXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 06:23:45 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:58279 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266193AbUITKXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 06:23:44 -0400
Date: Mon, 20 Sep 2004 12:23:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Olaf Hering <olh@suse.de>
cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
In-Reply-To: <20040920094602.GA24466@suse.de>
Message-ID: <Pine.LNX.4.61.0409201220200.3460@scrub.home>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Sep 2004, Olaf Hering wrote:

>  On Mon, Sep 20, Andries.Brouwer@cwi.nl wrote:
> 
> > then /etc/mtab can die. Comments? Better solutions?
> 
> Andries, /etc/mtab is obsolete since the day when /proc/self/mounts was
> introduced. So, kill it today from your mount binary! TODAY. ...

How do you distinguish between manual and automatic loop device setup?
How do you filter /proc/mounts for chroot environments?

bye, Roman
