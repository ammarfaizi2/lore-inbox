Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289014AbSANUS0>; Mon, 14 Jan 2002 15:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSANURO>; Mon, 14 Jan 2002 15:17:14 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:17928 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S288992AbSANUQr>;
	Mon, 14 Jan 2002 15:16:47 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200201142016.XAA10180@ms2.inr.ac.ru>
Subject: Re: Multicast fails when interface changed
To: cjames@berkeley.INnomedia.COM (Christopher James)
Date: Mon, 14 Jan 2002 23:16:23 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C3E3AAB.749B1D51@berkeley.innomedia.com> from "Christopher James" at Jan 11, 2 04:15:02 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> the app (vocal 1.2) does not use INADDR_ANY for imr_interface when
> joining the multicast group

Hmm... and what does it use?

As soon as /proc/net/dev_mcast does not show membership on the second
interface, it is not difficult to conclude that the applciation just forgot to
request mmembership on it.

Alexey
