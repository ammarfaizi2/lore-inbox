Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264314AbUD0Tk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbUD0Tk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbUD0Tk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:40:58 -0400
Received: from mail1.drkw.com ([62.129.121.35]:422 "EHLO mail1.drkw.com")
	by vger.kernel.org with ESMTP id S264314AbUD0Tkj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:40:39 -0400
From: "Heilmann, Oliver" <Oliver.Heilmann@drkw.com>
To: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, davej@redhat.com,
       oschoett@t-online.de
Subject: Re: [PATCH] SIS AGP vs 2.6.6-rc2
In-Reply-To: <200404271929.16786.volker.hemmann@heim9.tu-clausthal.de>
References: <20040426082159.90513.qmail@web10102.mail.yahoo.com> 
    <1082971956.24569.2.camel@pandora> <1083063853.24569.88.camel@pandora> 
    <200404271929.16786.volker.hemmann@heim9.tu-clausthal.de>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1083094853.7581.14.camel@pandora>
Mime-Version: 1.0
Date: Tue, 27 Apr 2004 20:40:54 +0100
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Mail-From: Oliver.Heilmann@drkw.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot, this (-l) will probably do the trick for you:
patch -p1 -l < sis.agp.patch

On Tue, 2004-04-27 at 18:29, Hemmann, Volker Armin wrote:
> Hi,
> I tried your patch and is has rejects again:
> energy linux # patch -p1 < sis.agp.patch
> patching file drivers/char/agp/sis-agp.c
> Hunk #1 succeeded at 13 with fuzz 2.
> Hunk #2 succeeded at 69 with fuzz 2.
> Hunk #3 FAILED at 96.
> Hunk #4 FAILED at 224.
> 2 out of 5 hunks FAILED -- saving rejects to file 
> drivers/char/agp/sis-agp.c.rej
> 
> Attached is the .rej file. 
> 
> Glück Auf
> Volker


--------------------------------------------------------------------------------
The information contained herein is confidential and is intended solely for the
addressee. Access by any other party is unauthorised without the express
written permission of the sender. If you are not the intended recipient, please
contact the sender either via the company switchboard on +44 (0)20 7623 8000, or
via e-mail return. If you have received this e-mail in error or wish to read our
e-mail disclaimer statement and monitoring policy, please refer to 
http://www.drkw.com/disc/email/ or contact the sender.
--------------------------------------------------------------------------------

