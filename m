Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSJEXzA>; Sat, 5 Oct 2002 19:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbSJEXzA>; Sat, 5 Oct 2002 19:55:00 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:18702 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S262812AbSJEXy7>;
	Sat, 5 Oct 2002 19:54:59 -0400
Message-ID: <52048.172.195.7.102.1033863271.squirrel@mail.orbita1.ru>
Date: Sun, 6 Oct 2002 04:14:31 +0400 (MSD)
Subject: [Q] 2.4.6 compatibility cruft in 8250_pci.c
From: "Andrey Panin" <pazke@orbita1.ru>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

do we really need these lines now ?

/* 2.4.6 compatinility cruft ... */
#define pci_board __pci_board
#include <serialP.h>
#undef pci_board

I'm trying to forward port a patch moving SIIG combo cards support
from serial driver into parport_serial.c and these lines are on my
way :)


