Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRCFVB1>; Tue, 6 Mar 2001 16:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129502AbRCFVBS>; Tue, 6 Mar 2001 16:01:18 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:18956
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129473AbRCFVBF>; Tue, 6 Mar 2001 16:01:05 -0500
Date: Tue, 6 Mar 2001 12:59:37 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
In-Reply-To: <20010306214838.V2803@suse.de>
Message-ID: <Pine.LNX.4.10.10103061255301.13719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Jens Axboe wrote:

> But I might want to do this (write sector 0), why would we want
> to filter that? If someone a) uses an email client that will execute
> java script code (or whatever) and b) runs that as root (which
> he would have to do, surely no ordinary user has privileges to send
> arbitrary commands) then he gets what he deserves.

Jens we are not going there....the filter is the only way known to jam
unknown commands, and you missed the point of the issue then and I think
you still miss it.  "arbitrary commands" + wrong hander is lock-up.
Everyone can do this, and that is fine.  I will not stop the drive-command
ioctl from issuing a drive-data command, you win!

Regards,

Andre Hedrick
Linux ATA Development

