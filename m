Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbSK0NQ0>; Wed, 27 Nov 2002 08:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSK0NQZ>; Wed, 27 Nov 2002 08:16:25 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:7829 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262480AbSK0NQZ>; Wed, 27 Nov 2002 08:16:25 -0500
Subject: Re: [PATCH-2.5.47-ac6] More IDE updates (BIOS, simplex, etc)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: Andre Hedrick <andre@linux-ide.org>, alan@xorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20021127125520.GF1356@tmathiasen>
References: <20021125134157.GA1187@tmathiasen>
	<Pine.LNX.4.10.10211252144200.13936-100000@master.linux-ide.org> 
	<20021127125520.GF1356@tmathiasen>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 13:54:56 +0000
Message-Id: <1038405296.6394.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-27 at 12:55, Torben Mathiasen wrote:
> Alan mentioned some missing locking in the IDE code, I assume thats what this
> is about, or does it only affect the taskfile stuff?

The locking is general stuff - eg write to a proc entry as the device is
switched from ide-cd to ide-scsi. Switch a device to ide-scsi as you
remove it - and so on

