Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbTAJTBj>; Fri, 10 Jan 2003 14:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbTAJTBg>; Fri, 10 Jan 2003 14:01:36 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4755
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266930AbTAJTB3>; Fri, 10 Jan 2003 14:01:29 -0500
Subject: Re: Fastest possible UDMA - how?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Knigge <Michael.Knigge@set-software.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030110.18485381@knigge.local.net>
References: <20030110.18485381@knigge.local.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042228590.32431.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 19:56:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 18:48, Michael Knigge wrote:
> Hi all,
> 
> is it somehow possible to determine what is the fastest UDMA-Mode my 
> IDE-Controller supports - independant of the chipset?

Not really. You have to know the specific device to know how to
query the modes it supports (if indeed you can query and don't have
the driver knowing by type)

