Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317907AbSGKUmI>; Thu, 11 Jul 2002 16:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317908AbSGKUmH>; Thu, 11 Jul 2002 16:42:07 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:36619 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317907AbSGKUmA>; Thu, 11 Jul 2002 16:42:00 -0400
Date: Thu, 11 Jul 2002 22:44:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFFS fix return without releasing BKL
In-Reply-To: <3D2D338F.109@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207112236330.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Jul 2002, Dave Hansen wrote:

> This was found by Dan Carpenter <error27@email.com>, using an smatch
> script.  Looks to me like like an error caused during all the BKL
> pushing.  1 more coming...

Actually lock_kernel() and the test there can be removed completely.

bye, Roman

