Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130670AbQLQSzF>; Sun, 17 Dec 2000 13:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130685AbQLQSy4>; Sun, 17 Dec 2000 13:54:56 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:17670 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S130668AbQLQSyh>; Sun, 17 Dec 2000 13:54:37 -0500
Date: Sun, 17 Dec 2000 13:23:52 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Lars Marowsky-Bree <lmb@suse.de>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Monitoring filesystems / blockdevice for errors
In-Reply-To: <20001217153453.O5323@marowsky-bree.de>
Message-ID: <Pine.LNX.4.10.10012171314050.16143-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> currently, there is no way for an external application to monitor whether a
> filesystem or underlaying block device has hit an error condition - internal
> inconsistency, read or write error, whatever.
> 
> Short of parsing syslog messages, which isn't particularly great.

what's wrong with it?  reinventing /proc/kmsg and klogd would be tre gross.

> I don't have a real idea how this could be added, short of adding a field to
> /proc/partitions (error count) or something similiar.

for reporting errors, that might be OK, but it's not a particularly nice
_notification_ mechanism...

regards, mark hahn.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
