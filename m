Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312604AbSCVOmh>; Fri, 22 Mar 2002 09:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312606AbSCVOm0>; Fri, 22 Mar 2002 09:42:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56839 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312604AbSCVOmJ>; Fri, 22 Mar 2002 09:42:09 -0500
Subject: Re: max partition size
To: michal@harddata.com (Michal Jaegermann)
Date: Fri, 22 Mar 2002 14:58:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020322005037.A9256@mail.harddata.com> from "Michal Jaegermann" at Mar 22, 2002 12:50:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16oQUp-0008CY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that.  But practice seems to indicate that 2 TB, or whereabout, can be
> too much.  Is this a property of a file system or we bumping into
> block device boundaries or this are just tools?

Could be a bug in the drivers or request code doing writeahead
past the boundary I guess
