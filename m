Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTLWSvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTLWSvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:51:09 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:30872 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262356AbTLWSup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:50:45 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: jcwren@jcwren.com, linux-kernel@vger.kernel.org
Subject: Re: Prevailence of PS/2 Active Muxed devices?
Date: Tue, 23 Dec 2003 13:50:39 -0500
User-Agent: KMail/1.5.4
References: <20031223180429.GA11198@dreamland.darkstar.lan> <200312231325.39712.jcwren@jcwren.com>
In-Reply-To: <200312231325.39712.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312231350.39160.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 December 2003 01:25 pm, J.C. Wren wrote:
>         Looking through the kernel sources, I see no handling for this.
>  From a big picture perspective, how does Linux handle a system with an
> integrated mouse pad, and an external PS/2 mouse port?  Is this whole
> Synaptics idea dead, or is support for this planned, or even
> considered?  Does any one have any knowledge the number of KBCs with
> this muxing?

No, it's alive and kicking... see drivers/input/serio/i8042.c -
i8042_check_mux()

Dmitry
