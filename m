Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTLALoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 06:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTLALoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 06:44:20 -0500
Received: from imap.gmx.net ([213.165.64.20]:52135 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261311AbTLALoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 06:44:18 -0500
X-Authenticated: #2203603
Message-ID: <011001c3b800$32c88a20$7727048b@de.uu.net>
From: "Daniel Flinkmann" <dflinkmann@gmx.de>
To: <ookhoi@humilis.net>
Cc: <linux-kernel@vger.kernel.org>
References: <200311290156.02239.DFlinkmann@gmx.de> <20031201112112.GA22180@favonius>
Subject: Re: 2.6.0test11 overwriting file on mounted smb volume causes corrupted files!
Date: Mon, 1 Dec 2003 12:42:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ookhoi,

> > [Please CC to me directly, I'm not on the linix kernel mailing list]
> >
> > [1.] One line summary of the problem:
> >
> > 2.6.0test11 overwriting file on mounted smb volume causes corrupted
files!
>
> I saw te same with -test9 with cifs.
> For some reason the November archive of
> http://lists.samba.org/archive/samba-technical/ is gone, but google has
> my report cached. Search for:
>
> "problem with updating files on cifs mount"
>
> I'm still stuck btw.
>

I believe that this issue is a memorymanagement issue, because cifs and
smbfs
are ram based file systems. This could be a even more critical issue then we
are expecting.

This is really causing file damages in eventually more than just smbfs and
cifs
systems.

Daniel

PS: I made a second Thread with "PROBLEM: Corrupt files with kernel
2.6.0_test11 and smb mounts" in the
subject, to meet the bug report requirements.



