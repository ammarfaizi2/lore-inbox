Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293700AbSCKJrA>; Mon, 11 Mar 2002 04:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293699AbSCKJqx>; Mon, 11 Mar 2002 04:46:53 -0500
Received: from mail49-s.fg.online.no ([148.122.161.49]:46740 "EHLO
	mail49.fg.online.no") by vger.kernel.org with ESMTP
	id <S293656AbSCKJqr>; Mon, 11 Mar 2002 04:46:47 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: r.turk@chello.nl (Rob Turk), linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <E16kAxQ-0007MV-00@the-village.bc.nu>
From: Harald Arnesen <gurre@start.no>
Date: Mon, 11 Mar 2002 10:46:01 +0100
In-Reply-To: <E16kAxQ-0007MV-00@the-village.bc.nu> (Alan Cox's message of
 "Sun, 10 Mar 2002 21:34:20 +0000 (GMT)")
Message-ID: <874rjn5teu.fsf@basilikum.skogtun.org>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> It was fabulous at that time. The first time you create a file, it
>> gets ";1" appended to it's filename. When you edit it, it gets saved
>> under the same name, this time appended by ";2". Edit it again...
>> whell, you get the picture. Cleaning up was as simple as "$ PURGE
>> /KEEP=3" to keep the last three versions.

> Its trickier than that - because all your other semantics have to align,
> its akin to the undelete problem (in fact its identical). Do you version on
> a rewrite, on a truncate, only on an O_CREAT ?

The Sintran OS for the Norsk Data minicomputers had something similar. A
new version was created every time a file was opened for writing.

It had its disadvantages. A typical machine where I worked at the time
had one 60MB disk. However, you could set the number of copies on a
per-file-basis, so big databases wouldn't have to be duplicated.
-- 
Hilsen Harald.
