Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318292AbSH0AL7>; Mon, 26 Aug 2002 20:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318302AbSH0AL7>; Mon, 26 Aug 2002 20:11:59 -0400
Received: from shaft18-f175.dialo.tiscali.de ([62.246.18.175]:7628 "EHLO
	shaft18-f175.dialo.tiscali.de") by vger.kernel.org with ESMTP
	id <S318292AbSH0AL7>; Mon, 26 Aug 2002 20:11:59 -0400
Date: Tue, 27 Aug 2002 02:15:54 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Michael Bellion <bellion@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Finding out whether memory was allocated with kmalloc or vmalloc
Message-ID: <20020827021553.A20963@bacchus.dhis.org>
References: <200208270406.16597.bellion@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208270406.16597.bellion@gmx.de>; from bellion@gmx.de on Tue, Aug 27, 2002 at 04:06:16AM +0200
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 04:06:16AM +0200, Michael Bellion wrote:

> given a pointer p, is there an easy and platform independent way to find out, 
> whether the memory location that p points to was allocated with kmalloc or 
> vmalloc?

Vmalloc'ed memory has a virtual address VMALLOC_START <= x < VMALLOC_END.

  Ralf
