Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318855AbSHET6O>; Mon, 5 Aug 2002 15:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318857AbSHET6O>; Mon, 5 Aug 2002 15:58:14 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:51652 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318855AbSHET6O>; Mon, 5 Aug 2002 15:58:14 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208052000.g75K0je13292@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.19-ac4
To: bunk@fs.tum.de (Adrian Bunk)
Date: Mon, 5 Aug 2002 16:00:45 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0208052149400.27501-100000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at Aug 05, 2002 09:59:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > o	Fix __FUNCTION__ warnings in reiserfs		(me)
> >...
> 
> The change to include/linux/reiserfs_fs.h broke the compilation of
> fs/reiserfs/bitmap.c (args in RASSERT can be nonexistant):

Gaah yet another gcc preprocessor bug in 2.95

I could get so bored of those. I'll add a workaround
