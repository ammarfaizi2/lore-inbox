Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVDEOwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVDEOwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVDEOwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:52:34 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.25]:57258 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261767AbVDEOw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:52:28 -0400
X-ME-UUID: 20050405145227406.631661C00289@mwinf0606.wanadoo.fr
Date: Tue, 5 Apr 2005 16:49:04 +0200
To: Troy Benjegerdes <hozer@hozed.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sven Luther <sven.luther@wanadoo.fr>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: PATCH: separate non-GPL tg3 firmware from GPL driver file
Message-ID: <20050405144904.GA25311@pegasos>
References: <20050405141258.GS26127@kalmia.hozed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050405141258.GS26127@kalmia.hozed.org>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 09:12:58AM -0500, Troy Benjegerdes wrote:
> Please either apply the following somewhere, or consider this a request 
> for the human-readable version of the "tg3TsoFwText" string, per the GPL
> requirements.

Notice that the same thing comes from (one of) the drivers distributed by
broadcom directly from :

  http://www.broadcom.com/drivers/driver-sla.php?driver=570x-Linux

$ cat fw_lso05.h
/******************************************************************************/
/*                                                                            */
/* Broadcom BCM5700 Linux Network Driver, Copyright (c) 2000 - 2003 Broadcom  */
/* Corporation.                                                               */
/* All rights reserved.                                                       */
/*                                                                            */
/* This program is free software; you can redistribute it and/or modify       */
/* it under the terms of the GNU General Public License as published by       */
/* the Free Software Foundation, located in the file LICENSE.                 */
/*                                                                            */
/* (c) COPYRIGHT 2001-2004 Broadcom Corporation, ALL RIGHTS RESERVED.         */
/*                                                                            */
/*  Name: F W _ L S O 0 5. H                                                  */
/*  Author : Kevin Tran                                                       */
/*  Version: 1.2                                                              */
/*                                                                            */
/* Module Description:  This file contains firmware binary code of TCP        */
/* Segmentation firmware (BCM5705).                                           */
/*                                                                            */
/* History:                                                                   */
/*    08/10/02 Kevin Tran       Incarnation.                                  */
/*    02/02/04 Kevin Tran       Added Support for BCM5788.                    */
/******************************************************************************/
...
U32 t3StkOffLd05FwText[(0xe90/4) + 1] = {
0xc004003, 0x0, 0x10f04, 
0x0, 0x10000003, 0x0, 0xd, 
0xd, 0x3c1d0001, 0x37bde000, 0x3a0f021, 
0x3c100001, 0x26100000, 0xc004010, 0x0, 
...

It is specially ironic to see the GPL advertizement and the firmware binary
words together :)

Will contact their driver support team, and see what it gives.

Friendly,

Sven Luther

