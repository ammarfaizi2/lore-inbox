Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbTC3Pij>; Sun, 30 Mar 2003 10:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261389AbTC3Pij>; Sun, 30 Mar 2003 10:38:39 -0500
Received: from [81.2.110.254] ([81.2.110.254]:43765 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261387AbTC3Pii>;
	Sun, 30 Mar 2003 10:38:38 -0500
Subject: Re: linux kernel IDE development process question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeremy Jackson <jerj@coplanar.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048955308.1467.20.camel@contact.skynet.coplanar.net>
References: <1048955308.1467.20.camel@contact.skynet.coplanar.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049039480.14686.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 30 Mar 2003 16:51:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 16:28, Jeremy Jackson wrote:
> I would like to know what code is kept in sync between 2.4/2.5
> (2.2/2.0?).  This way I can start by understanding what is already being
> done. This is related to the recent "hdparm and removable IDE?" thread
> on LKML.

None of it.

> I would like to start by declaring ide_hwifs[] static, and removing the
> extern ide_hwifs from ide.h.  all references to ide_hwifs[] will be
> converted to macros and/or access method functions, that return a

Feel free, its your tree. If it cleans up stuff a lot it may be a
workable change for 2.5. Don't overdo the access function stuff though
our you'll make things slower and larger.

Alan

