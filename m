Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261563AbSIXFHP>; Tue, 24 Sep 2002 01:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261566AbSIXFHP>; Tue, 24 Sep 2002 01:07:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4799 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261563AbSIXFHP>;
	Tue, 24 Sep 2002 01:07:15 -0400
Date: Mon, 23 Sep 2002 22:02:23 -0700 (PDT)
Message-Id: <20020923.220223.125097727.davem@redhat.com>
To: jgarzik@pobox.com
Cc: ac9410@attbi.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] linux-2.5.38 new i2c parallel port adapter
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D8FF30A.1060609@pobox.com>
References: <Pine.LNX.4.44.0209240044400.16117-200000@home1>
	<3D8FF30A.1060609@pobox.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@pobox.com>
   Date: Tue, 24 Sep 2002 01:07:22 -0400

   Albert Cranford wrote:
   > +#define DEFAULT_BASE 0x378
   
   surely there is a parport define for this?
   
Probably this driver should be hooked into the generic
parport infrastructure, then every architecture no matter
where the parport regs actually live could make use of it.
