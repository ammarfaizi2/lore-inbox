Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131415AbRCSP3K>; Mon, 19 Mar 2001 10:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131502AbRCSP3A>; Mon, 19 Mar 2001 10:29:00 -0500
Received: from [212.115.175.146] ([212.115.175.146]:61690 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S131415AbRCSP2l>; Mon, 19 Mar 2001 10:28:41 -0500
Message-ID: <27525795B28BD311B28D00500481B7601F1014@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: "Amit S. Kale" <akale@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: RE: Per user private directories - trfs
Date: Mon, 19 Mar 2001 16:27:25 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Translators for providing per user private directories and restricting
> visibility of files and directories using the translation filesystem are
> available now at
> http://trfs.sourceforge.net/
> Per user private directories:
> Files created in a per user private directory are not visible to users
> other than the owner of the files.

I like the concept, I would have done it different though: I would look
at the bits and see if a user can do anything with a file. Can
he/she (from now on I'll write 'xe' for that) read or write or execute a
file (or is owner of course)? -> file is visible. Xe is in group of file?
And Xe can r/w/x file? -> visible. all other cases: invisible.

