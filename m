Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbTDQIvb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 04:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbTDQIvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 04:51:31 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:13066 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S261281AbTDQIva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 04:51:30 -0400
Date: Thu, 17 Apr 2003 11:02:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Arjan van de Ven <arjanv@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
In-Reply-To: <1050569207.1412.1.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0304171102040.12110-100000@serv>
References: <Pine.LNX.4.44.0304161904170.1534-100000@home.transmeta.com>
 <1050569207.1412.1.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17 Apr 2003, Arjan van de Ven wrote:

> it can do that ANYWAY for all kinds of things.
> We really should ask the gcc folks to add a
> -fdontyoudareusefloatingpoint flag (well different name probably) to
> make sure it never ever will generate FP code. (would also help catch
> abusers of FP code in the kernel as a bonus ;)

-msoft-float?

bye, Roman

