Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317993AbSGWINj>; Tue, 23 Jul 2002 04:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317994AbSGWINj>; Tue, 23 Jul 2002 04:13:39 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:50450 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317993AbSGWINi>; Tue, 23 Jul 2002 04:13:38 -0400
Date: Tue, 23 Jul 2002 10:16:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, <linux-security-module@wirex.com>
Subject: Re: [BK PATCH] LSM changes for 2.5.27
In-Reply-To: <20020723003806.GB660@kroah.com>
Message-ID: <Pine.LNX.4.44.0207231012240.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 22 Jul 2002, Greg KH wrote:

> +		error = security_ops->inode_setattr(dentry, attr);

Am I the only one who'd like to see this as an inline function?
1. It can be optimized away.
2. It's easier to read.

bye, Roman


