Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264730AbVBDOoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264730AbVBDOoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbVBDOoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:44:15 -0500
Received: from smtp12.wanadoo.fr ([193.252.22.20]:4397 "EHLO smtp12.wanadoo.fr")
	by vger.kernel.org with ESMTP id S266384AbVBDOn0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 09:43:26 -0500
X-ME-UUID: 20050204144325687.A7EDD1C000B3@mwinf1202.wanadoo.fr
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI]
	Samsung P35, S3, black screen (radeon))
From: Xavier Bestel <xavier.bestel@free.fr>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, Pavel Machek <pavel@ucw.cz>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339105020321031ccaabb@mail.gmail.com>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>
	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>
	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
	 <9e47339105020321031ccaabb@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 04 Feb 2005 15:40:57 +0100
Message-Id: <1107528057.6191.128.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 04 février 2005 à 00:03 -0500, Jon Smirl a écrit :
> Doing this in user space lets you have two reset
> programs, vm86 and emu86 for non-x86 machines.

Perhaps only emu86 should be used, to have a well-debugged codepath on
all archs (amd64, ppc, ...)
As it's usermode, the code size is less of a problem.

	Xav


