Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129498AbRCFVVR>; Tue, 6 Mar 2001 16:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRCFVVH>; Tue, 6 Mar 2001 16:21:07 -0500
Received: from puce.csi.cam.ac.uk ([131.111.8.40]:60110 "EHLO
	puce.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129498AbRCFVUu>; Tue, 6 Mar 2001 16:20:50 -0500
Date: Tue, 6 Mar 2001 21:23:47 +0000 (GMT)
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Andre Hedrick <andre@linux-ide.org>
cc: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
In-Reply-To: <Pine.LNX.4.10.10103061255301.13719-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.30.0103062119420.9088-100000@dax.joh.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Andre Hedrick wrote:

> On Tue, 6 Mar 2001, Jens Axboe wrote:
>
> > But I might want to do this (write sector 0), why would we want
> > to filter that? If someone a) uses an email client that will execute
> > java script code (or whatever) and b) runs that as root (which
> > he would have to do, surely no ordinary user has privileges to send
> > arbitrary commands) then he gets what he deserves.
>
> Jens we are not going there....the filter is the only way known to jam
> unknown commands,

Erm... the hoax "virus" was about writing to the first sector of the disk,
overriding the partition table. If "write data" is an "unknown command",
HTF am I supposed to store data on my HDD? :P

> and you missed the point of the issue then and I think you still miss
> it.  "arbitrary commands" + wrong hander is lock-up. Everyone can do
> this, and that is fine.  I will not stop the drive-command ioctl from
> issuing a drive-data command, you win!

Hrm. I like the idea of being able to filter out dodgy commands from
hitting the drive: there's a difference between the Unix philosophy of
"enough rope" and the NT approach of everything having a landmine on top
with a big red button marked "press this and see!" :)


James.

