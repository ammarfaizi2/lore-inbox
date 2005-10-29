Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVJ2LGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVJ2LGE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbVJ2LGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:06:04 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:48520 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750936AbVJ2LGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:06:02 -0400
Subject: Re: [PATCH] bluetooth hidp is broken on s390
From: Marcel Holtmann <marcel@holtmann.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
In-Reply-To: <20051029110200.GH7992@ftp.linux.org.uk>
References: <20051029110200.GH7992@ftp.linux.org.uk>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 13:05:49 +0200
Message-Id: <1130583949.6428.1.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

> 	Bluetooth HIDP selects INPUT and it really needs it to be
> there - module depends on input core.  And input core is never
> built on s390...  Marked as broken on s390, for now; if somebody
> has better ideas, feel free to fix it and remove dependency...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

basically I think someone should fix the input layer on S390, but I am
fine with your fix.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


