Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWBLK1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWBLK1w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 05:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWBLK1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 05:27:52 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:23245 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932379AbWBLK1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 05:27:51 -0500
Date: Sun, 12 Feb 2006 11:27:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linda Walsh <lkml@tlinx.org>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
In-Reply-To: <43ED5A7B.7040908@tlinx.org>
Message-ID: <Pine.LNX.4.61.0602121126410.25363@yvahk01.tjqt.qr>
References: <43ED5A7B.7040908@tlinx.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The maximum number of followed symlinks seems to be set to 5.
>

# grep 40 fs/namei.c
namei.c: * limiting consecutive symlinks to 40.
namei.c:        if (current->total_link_count >= 40)



Jan Engelhardt
-- 
