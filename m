Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbQJ3Xdd>; Mon, 30 Oct 2000 18:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129517AbQJ3XdY>; Mon, 30 Oct 2000 18:33:24 -0500
Received: from quechua.inka.de ([212.227.14.2]:5900 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129609AbQJ3XdL>;
	Mon, 30 Oct 2000 18:33:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: /proc & xml data
In-Reply-To: <39FCDB16.B0955558@mindspring.com>
Date: Tue, 31 Oct 2000 00:20:45 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E13qOEP-0006NC-00@hunte.bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "MemTotal:  %8lu kB\n"
> to something like
> "<memtotal>%8lu kB</memtotal>\n"

The latter form offers no significant advantage over the former at
all - there is nothing that can be expressed as
 <name>value</name>
which can't also be expressed as
 name: value
or
 name=value
and the latter format is significantly easier to parse.

The only situation where XML really would be useful would be
some need of grouping, and this is done in /proc using directories.
(Which are also much easier to parse using existing standard tools.)

Olaf

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
