Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273129AbRIJBbB>; Sun, 9 Sep 2001 21:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273140AbRIJBav>; Sun, 9 Sep 2001 21:30:51 -0400
Received: from zok.SGI.COM ([204.94.215.101]:12518 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S273129AbRIJBai>;
	Sun, 9 Sep 2001 21:30:38 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: mzyngier@freesurf.fr
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Missing exports in genhd.c in 2.4.10-pre 
In-Reply-To: Your message of "09 Sep 2001 20:13:52 +0200."
             <wrplmjodyfz.fsf@hina.wild-wind.fr.eu.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Sep 2001 11:29:59 +1000
Message-ID: <18878.1000085399@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Sep 2001 20:13:52 +0200, 
Marc ZYNGIER <mzyngier@freesurf.fr> wrote:
>Please find attached a small patch (against 2.4.10-pre6) which adds
>missing EXPORT_SYMBOLs to genhd.c. Without it, modules such as
>sd_mod.o are unable to load...

You need to add genhd.o to export-objs in drivers/block/Makefile as well.

