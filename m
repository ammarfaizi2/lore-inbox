Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUAWTET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266651AbUAWTET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:04:19 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:44946 "EHLO
	mail4.ewetel.de") by vger.kernel.org with ESMTP id S266650AbUAWTEQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:04:16 -0500
Date: Fri, 23 Jan 2004 20:04:12 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
In-Reply-To: <Pine.LNX.4.55.0401231954430.3223@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0401232002280.1069-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004, Maciej W. Rozycki wrote:

> Hmm, given MO is a removable direct access device, I'd suppose ide-floppy
> would be used as the handling driver similarly to the Zip drive, wouldn't
> it?

No, ide-floppy refuses to use media with larger sectors than 512 bytes.

-- 
Ciao,
Pascal


