Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318259AbSHPJci>; Fri, 16 Aug 2002 05:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318260AbSHPJci>; Fri, 16 Aug 2002 05:32:38 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:21776
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318259AbSHPJci>; Fri, 16 Aug 2002 05:32:38 -0400
Date: Fri, 16 Aug 2002 02:27:03 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 boot failure on pdc20267
In-Reply-To: <2298DFF575E@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10208160223390.12468-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002, Petr Vandrovec wrote:

> Yes. If you'll look at d1510r0c.pdf from ATA guys, you'll find that

BUZZIT!

That is an totally new transport protocol and if you research the pci
device class you would know that it has nothing to do with the problem.
If you guys are playing with ADMA on DMA Hosts, oh my!

The context of what is the EOT between the two HOST protocols has no
meaning.

Regards,


Andre Hedrick
LAD Storage Consulting Group

