Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130071AbRCDQEc>; Sun, 4 Mar 2001 11:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130064AbRCDQEW>; Sun, 4 Mar 2001 11:04:22 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:17867 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130063AbRCDQES>; Sun, 4 Mar 2001 11:04:18 -0500
Message-ID: <3AA26659.89222B2B@coplanar.net>
Date: Sun, 04 Mar 2001 10:59:21 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Frédéric L. W. Meunier" <fredlwm1@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2: What happened ? (No such file or directory)
In-Reply-To: <20010304043531.60248.qmail@web11802.mail.yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

" Frédéric L. W. Meunier" wrote:

> Correction. I can umount the partitions, but I get the
> following message:
>
> "can't link lock file /etc/mtab~: No such file or
> directory (use -n flag to override)"
>
> And /etc/mtab isn't updated.

Is your root filesystem mounted read-only at any point?
(check with 'mount' look for ro in line for / filesystem)
Check permissions on /etc, /etc/mtab, /etc/mtab~


