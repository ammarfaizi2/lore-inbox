Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRF3UPz>; Sat, 30 Jun 2001 16:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262616AbRF3UPp>; Sat, 30 Jun 2001 16:15:45 -0400
Received: from martnet.com ([146.145.176.8]:34480 "EHLO home.martnet.com")
	by vger.kernel.org with ESMTP id <S262355AbRF3UPe>;
	Sat, 30 Jun 2001 16:15:34 -0400
Date: Sat, 30 Jun 2001 16:15:25 -0400
From: John Guthrie <guthrie@home.martnet.com>
Message-Id: <200106302015.QAA31629@home.martnet.com>
To: linux-kernel@vger.kernel.org
Subject: unable to read from IDE tape
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Lately, I have been having problems reading from from my HP Colorado IDE
tape drive.  I can use mt to get the status of the drive and to forward the
drive to a different file.  I can even use tar to write to the tape.
But whenever I try to read the tar files that I have written to tape, I
get an I/O error, and there doesn't even seem to be any attempt by the
driver to read the tape.  This is currently happening under 2.4.5, and
has been happening undeer at least 2.4.2 and 2.4.3, I think it was also
happening under 2.4.1 as well.

The system is a 200 MHz Pentium, with 128MB of RAM.  The tape drive is a
HP Colorado 5GB tape drive.  Currently I am running kernel 2.4.5 and using the
ide-tape module.

Any thoughts on what might be wrong?

Thanks in advance.

Sincerely,

John Guthrie
guthrie@martnet.com
