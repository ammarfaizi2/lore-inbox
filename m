Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271357AbTHDIkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 04:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271413AbTHDIkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 04:40:31 -0400
Received: from home.wiggy.net ([213.84.101.140]:30597 "EHLO
	thunder.home.wiggy.net") by vger.kernel.org with ESMTP
	id S271357AbTHDIka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 04:40:30 -0400
Date: Mon, 4 Aug 2003 10:40:29 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: chroot() breaks syslog() ?
Message-ID: <20030804084029.GB8179@wiggy.net>
Mail-Followup-To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <6416776FCC55D511BC4E0090274EFEF5080024AC@exchange.world.net> <20030804053438.GC31092@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804053438.GC31092@phunnypharm.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Ben Collins wrote:
> Enable devfs, and you can mount devfs anywhere, even in chroots, and it
> will propogate things like /dev/log.

Why not use a bind mount instead of forcing devfs on him?

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

