Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWIDHxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWIDHxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWIDHxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:53:09 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:35764 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932474AbWIDHxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:53:06 -0400
Date: Mon, 4 Sep 2006 09:49:11 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 19/22][RFC] Unionfs: Helper macros/inlines
In-Reply-To: <20060901015945.GT5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040947560.22518@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901015945.GT5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+/* Dentry macros */
>+static inline struct unionfs_dentry_info *dtopd(const struct dentry *dent)
>+{
>+	return (struct unionfs_dentry_info *)dent->d_fsdata;
>+}

Nocast.


Jan Engelhardt
-- 

-- 
VGER BF report: H 0
