Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTJPOwb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 10:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbTJPOwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 10:52:31 -0400
Received: from imap.gmx.net ([213.165.64.20]:64957 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262993AbTJPOwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 10:52:30 -0400
X-Authenticated: #1226656
Date: Thu, 16 Oct 2003 16:52:28 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>
Cc: Javier Achirica <achirica@telefonica.net>,
       Celso =?ISO-8859-1?Q?Gonz=E1lez?= <celso@mitago.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: airo regression with Linux 2.4.23-pre2
Message-Id: <20031016165228.3544622d.gigerstyle@gmx.ch>
In-Reply-To: <20031016155134.612b61d5.us15@os.inf.tu-dresden.de>
References: <20031015194754.GA14859@viac3>
	<Pine.SOL.4.30.0310152323320.21600-100000@tudela.mad.ttd.net>
	<20031016155134.612b61d5.us15@os.inf.tu-dresden.de>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> JA> > Try removing this line on airo.c
> JA> > Line 2948
> JA> > ai->config._reserved1a[0] = 2 /* ??? */
> 
> Removing the line mentioned above fixes my problems as well. Thanks
> Celso.

It fixes the problem by me too.

Marc
