Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVDYKtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVDYKtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 06:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVDYKtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 06:49:19 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:42457 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S262579AbVDYKtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 06:49:17 -0400
Date: Mon, 25 Apr 2005 13:49:15 +0300 (EEST)
From: Heikki Orsila <shd@modeemi.cs.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-ID: <Pine.OSF.4.58.0504251344500.262468@fanta.modeemi.cs.tut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
> More generally:
>
> 1. the files exported by the FUSE filesystem should not be accessible
> by other users.

Not even by root. If an admin of a remote system runs a backup script, one
does not want private home computer files go with that. The admin of the
remote system does definitely not want to make backups of my home files.

Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
