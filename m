Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbRL3RG5>; Sun, 30 Dec 2001 12:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280537AbRL3RGr>; Sun, 30 Dec 2001 12:06:47 -0500
Received: from pop.gmx.de ([213.165.64.20]:42768 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S280126AbRL3RGe>;
	Sun, 30 Dec 2001 12:06:34 -0500
Message-ID: <3C2F498C.19D61D6E@gmx.net>
Date: Sun, 30 Dec 2001 18:06:20 +0100
From: Mike <maneman@gmx.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Lionel Bouton <Lionel.Bouton@free.fr>
Subject: Re: Oops: UMOUNTING in 2.4.17 / Ext2 Partitions destroyed (3x)
In-Reply-To: <3C2F2948.DB59646A@gmx.net> <3C2F2C1B.2000100@free.fr> <3C2F3823.461F36F6@gmx.net> <3C2F481F.3070607@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton wrote:

>  From my experience with this chipset you might not have lost much data.
> If your e2fsck failed without the opportunity to ever write something,
> booting with "ide=nodma" and only then performing a filesystem check
> might put the system on its feet again.
>

I have NOW put "append = "ide=nodma"" in my /etc/lilo.conf, Thank you.
Yes, please keep me posted.
-Mike


