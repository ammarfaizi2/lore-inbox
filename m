Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSLaOOK>; Tue, 31 Dec 2002 09:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSLaOOK>; Tue, 31 Dec 2002 09:14:10 -0500
Received: from mail.scram.de ([195.226.127.117]:49091 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S262813AbSLaOOK>;
	Tue, 31 Dec 2002 09:14:10 -0500
Date: Tue, 31 Dec 2002 15:22:28 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
To: John Bradford <john@grabjohn.com>
cc: Xavier Bestel <xavier.bestel@free.fr>, <andrew@walrond.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <200212311219.gBVCJjJM001277@darkstar.example.net>
Message-ID: <Pine.NEB.4.44.0212311518570.9962-100000@www2.scram.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

> Are drivers for Alpha, Sparc, or anything else with a pci slot apart
> from an X86 machine available?

Unfortunately, that wouldn't be enought. There are lots of PCI graphics
cards available, which still only work in an X86 (and in most cases Alpha)
machines, although there is an open source driver. The reason is that they
need the initialisation code in their PCI BIOS, which is X86, binary code.
Alpha works around this by using an X86 emulator in their PAL code.

--jochen

