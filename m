Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283782AbRL1PUO>; Fri, 28 Dec 2001 10:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286926AbRL1PUF>; Fri, 28 Dec 2001 10:20:05 -0500
Received: from cti06.citenet.net ([206.123.38.70]:61189 "EHLO
	cti06.citenet.net") by vger.kernel.org with ESMTP
	id <S286927AbRL1PTz>; Fri, 28 Dec 2001 10:19:55 -0500
From: Jacques Gelinas <jack@solucorp.qc.ca>
Date: Fri, 28 Dec 2001 09:36:13 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: file names ?
X-mailer: tlmpmail 0.1
Message-ID: <20011228093613.917de25dc62c@remtk.solucorp.qc.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Dec 2001 15:36:46 -0500, Nicholas Knight wrote

> Actually there should be *no* problem at all. Just enable UMSDOS and
> the UMSDOS filesystem will take care of ensuring that the FAT
> filesystem supports the links, and the same filenames. Just don't try
> to extract the files anywhere but in Linux with UMSDOS enabled.
>
> Err, and don't run scandisk or anything similar on the drives while in
> DOS/Windows....

umsdos has no problems with scandisk. hardlinks are represented as special
symlinks for example.

---------------------------------------------------------
Jacques Gelinas <jack@solucorp.qc.ca>
vserver: run general purpose virtual servers on one box, full speed!
http://www.solucorp.qc.ca/miscprj/s_context.hc
