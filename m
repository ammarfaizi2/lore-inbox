Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132540AbRDWXVz>; Mon, 23 Apr 2001 19:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132574AbRDWXUH>; Mon, 23 Apr 2001 19:20:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11017 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132537AbRDWXQX>; Mon, 23 Apr 2001 19:16:23 -0400
Subject: Re: i810_audio broken?
To: pawel.worach@mysun.com
Date: Tue, 24 Apr 2001 00:17:54 +0100 (BST)
Cc: chmouel@mandrakesoft.com (Chmouel Boudjnah),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3829d3430e.3430e3829d@mysun.com> from "Pawel Worach" at Apr 24, 2001 12:39:23 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rpaf-0000lN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok building mpg123 without eSound worked for me too,
> so guess this is not a Linux kernel issue, sorry for this.

Excellent.

> eSound sux?

esound has very broken rate conversion support (it converts the audio but rather
damages it on the way). Gnome is moving towards using the KDE arts daemon which
currently seems to get it right.

