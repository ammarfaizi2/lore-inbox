Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTJGQLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTJGQLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:11:55 -0400
Received: from main.gmane.org ([80.91.224.249]:23012 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261735AbTJGQLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:11:53 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: devfs vs. udev
Date: Tue, 07 Oct 2003 18:11:49 +0200
Message-ID: <yw1x7k3hc9iy.fsf@users.sourceforge.net>
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <pan.2003.10.07.13.41.23.48967@dungeon.inka.de>
 <yw1xekxpdtuq.fsf@users.sourceforge.net> <20031007142349.GX1223@rdlg.net>
 <pan.2003.10.07.16.06.52.842471@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:gfUYuqGH2/QFSq8oRpuoXZuCZd4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus <aj@dungeon.inka.de> writes:

>> I just hope udev can give a look/feel similar to devfs as I have quite a
>> few machines already in production configured for devfs and really like
>> the manageablility.
>
> I wonder: do you use the /dev/disc/* links, or the /dev/ide/... and
> /dev/scsi/... constructs? I'm not sure how udev will be able to 
> support both layouts.
>
> Also: do you prefer a devs compatible layout, or maybe use the change
> for a cleanup? a short list of obscurities: /dev/cdroms/cdrom0 but
> /dev/printers/0 and /dev/tts/0 and /dev/floppy but /dev/discs etc. also
> all floppy devices are in /dev/floopy, where each disc has is
> /dev/discs/discN directory/symlink. I think it's a good opportunity
> for a cleanup, but that wouldn't be compatible...

I'm all for a cleanup.  Changing things don't bother me, I just want a
good reason.

-- 
Måns Rullgård
mru@users.sf.net

