Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268857AbTBZRxC>; Wed, 26 Feb 2003 12:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268854AbTBZRxC>; Wed, 26 Feb 2003 12:53:02 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:21655 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268857AbTBZRxB>; Wed, 26 Feb 2003 12:53:01 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302261803.h1QI3BT24020@devserv.devel.redhat.com>
Subject: Re: Tighten up serverworks workaround.
To: kimball@serverworks.com (Kimball Brown)
Date: Wed, 26 Feb 2003 13:03:10 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), davej@codemonkey.org.uk,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <OMEEJAEPHFDBEBPLINBDCELACNAA.kimball@serverworks.com> from "Kimball Brown" at Feb 26, 2003 09:27:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How can e help?  Please give me a configuration and how the bug manifests
> inself.

OSB4 chipset system, some memory areas marked write combining with the
processor memory type range registers. A long time ago Dell (I
think) reported corruption from this and submitted changes to block the
use of write combining on OSB4. The question has arisen as to whether
thats a known thing, and if so which release of the chipset fixed it so that
people can only apply such a restriction to problem cases not all OSB4.

Alan
