Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281609AbRLBRZv>; Sun, 2 Dec 2001 12:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281599AbRLBRZl>; Sun, 2 Dec 2001 12:25:41 -0500
Received: from cs6669235-16.austin.rr.com ([66.69.235.16]:26497 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S281609AbRLBRZc>; Sun, 2 Dec 2001 12:25:32 -0500
Date: Sun, 2 Dec 2001 11:25:30 -0600 (CST)
From: Erik Elmore <lk@bigsexymo.com>
X-X-Sender: <lk@localhost.localdomain>
To: Bernd Eckenfels <ecki@lina.inka.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: EXT3 - freeze ups during disk writes
In-Reply-To: <E16AX5E-0006pH-00@calista.inka.de>
Message-ID: <Pine.LNX.4.33.0112021121420.13663-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You should elaborate more on the type of disks writes. Is this a write to a
> single large file, a rename/delte of a large tree, ot generating of a lot of
> files. Cause there is a difference in the meta data and data handling. both
> where known to take too much time in different versions.

It appears when writing a single large file such as downloading or copying 
a file, and also when I copy a large number of smaller files at once.  I 
have noticed no performance hits when renaming or deleting a large number 
of files at once.

Erik


