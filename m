Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbUK3W3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbUK3W3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbUK3W3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:29:47 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6538 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262364AbUK3W3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:29:39 -0500
Subject: Re: [RFC] misleading error message
From: Lee Revell <rlrevell@joe-job.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0411302328450.3635@dragon.hygekrogen.localhost>
References: <001101c4d715$25a59470$af00a8c0@BEBEL>
	 <Pine.LNX.4.61.0411302251180.3635@dragon.hygekrogen.localhost>
	 <Pine.LNX.4.53.0411302310080.31695@yvahk01.tjqt.qr>
	 <Pine.LNX.4.61.0411302328450.3635@dragon.hygekrogen.localhost>
Content-Type: text/plain
Date: Tue, 30 Nov 2004 17:29:35 -0500
Message-Id: <1101853775.10162.44.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 23:29 +0100, Jesper Juhl wrote:
> > 
> > So how would you go about finding out whether something is compiled-in?
> > 
> Personally I'd just go check my kernels .config

zgrep CONFIG_FOO /proc/config.gz

This requires CONFIG_IKCONFIG_PROC.  Many distros inexplicably do not
enable this by default.

Lee

