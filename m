Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbTBJUx7>; Mon, 10 Feb 2003 15:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbTBJUx7>; Mon, 10 Feb 2003 15:53:59 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:35916 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S265096AbTBJUx6>; Mon, 10 Feb 2003 15:53:58 -0500
Date: Mon, 10 Feb 2003 23:04:42 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Kevin Fenzi <kevin-linux-kernel@scrye.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x end of tape handling error
In-Reply-To: <20030210182254.2913.qmail@scrye.com>
Message-ID: <Pine.LNX.4.52.0302102249480.804@kai.makisara.local>
References: <20030210182254.2913.qmail@scrye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This discussion should really be moved to linux-scsi...

On Mon, 10 Feb 2003, Kevin Fenzi wrote:

> Greetings.
>
> I have had reported from a client that they are having problems with
> backups that span more than one tape. Instead of getting an EOT error
> or EOM, they are getting an I/O error wich requires the driver to be
> unloaded and reloaded before the tape will work again.
>
What messages have they seen in the system log? Some messages should be
after this kind of error. It is difficult to see where the problem is
without any details. There have not been any significant changes in EOM
handling in st between the 2.4 kernels.

> http://www.linuxtapecert.org/ Says that the redhat 2.4.9-34 kernel is
> the last one that had proper EOT handling. Indeed, if they use the
> 2.4.9-34 kernel, the tape works properly. Thats not a very good
> solution however.
>
> Is this fixed in the latest 2.4.21-pres? How about in 2.5.x?
>
Don't know. EOM handling has worked with my test system (HP DDS drives
connected to a SYM53c896) with both 2.4 and 2.5 kernels. I just reran the
eom tests with 2.4.20 and 2.5.60 without problems.

	Kai
