Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUAGRJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUAGRJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:09:46 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:10503 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266246AbUAGRJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:09:43 -0500
Date: Wed, 7 Jan 2004 17:09:39 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Marek Habersack <grendel@caudium.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb and highmem?
In-Reply-To: <20040107153934.GB1119@thanes.org>
Message-ID: <Pine.LNX.4.44.0401071708120.30778-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is because of the radeonfb driver ioremapping the framebuffer memeory 
whichcan be really big. Once the driver is fully accelerated then we can 
remove the ioremap function in the driver.


On Wed, 7 Jan 2004, Marek Habersack wrote:

> Hey list,
> 
>   I was trying to find a patch fixing the problem of radeonfb with highmem,
> but failed miserably. Is there any patch out there that deals with the
> problem for 2.6.x?
> 
> TIA,
> 
> marek
> 

