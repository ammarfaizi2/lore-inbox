Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267035AbTBTXr3>; Thu, 20 Feb 2003 18:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbTBTXr3>; Thu, 20 Feb 2003 18:47:29 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:56068 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267035AbTBTXr2>; Thu, 20 Feb 2003 18:47:28 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302202357.h1KNvXo29517@devserv.devel.redhat.com>
Subject: Re: Linux 2.5.62-ac1
To: elenstev@mesatop.com (Steven Cole)
Date: Thu, 20 Feb 2003 18:57:33 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <1045783862.6615.82.camel@spc9.esa.lanl.gov> from "Steven Cole" at Feb 20, 2003 04:31:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ide_xlate_1024+0xf5
> read_dev_sector+0x69
> handle_ide_mess+0x179

Ok I broke it with the change to the partiton stuff I put back. If you drop
that partition tweak out it ought to boot.
